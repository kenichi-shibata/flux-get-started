.PHONY: clean helm_install_tiller helm_repo_add helm_install_flux_crd helm_install_flux

CONTROLLER_FLAGS ?=--controller=demo:helmrelease/ghost
IMAGE_FLAGS ?= --update-image=bitnami/ghost:1.22.7
POLICY_FLAGS ?= --tag-all='semver:1.25.*'
NS_FLAGS=--k8s-fwd-ns flux

check_env:
	@which git &> /dev/null || (echo "please install git"; exit 1)
	@which helm &> /dev/null || (echo "please install helm"; exit 1)
	@which kubectl &> /dev/null || (echo "please install kubectl"; exit 1)

github_user:
ifndef GITHUB_USER
	$(error GITHUB_USER is undefined)
endif

# Install tiller on the server side and initialize helm on client side
helm_install_tiller: check_env
	kubectl -n kube-system create serviceaccount tiller 
	kubectl create clusterrolebinding tiller-cluster-rule \
    --clusterrole=cluster-admin \
    --serviceaccount=kube-system:tiller \
	helm init --skip-refresh --upgrade --service--accout --tiller

# Add the helm repo where the flux chart exists
helm_repo_add: check_env
	helm repo add weaveworks https://weaveworks.github.io/flux

# Install the custom resource definition
helm_install_flux_crd: check_env
	kubectl apply -f https://raw.githubusercontent.com/weaveworks/flux/master/deploy-helm/flux-helm-release-crd.yaml

# Install the helm operator on the cluster
helm_install_flux: check_env github_user
	helm upgrade -i flux \
	--set helmOperator.create=true \
	--set helmOperator.createCRD=false \
	--set git.url=git@github.com:$(GITHUB_USER)/flux-get-started \
  --set registry.pollInterval=2m \
	--namespace flux \
	weaveworks/flux

# Look at the helm list of all releases 
# You can use `watch kubectl get pods -n flux` to check
helm_ls: check_env
	helm ls --namespace flux

# Look at the logs to see how the operator looks at the git and cluster and diff between them
helm_flux_logs: check_env
	kubectl -n flux logs deployment/flux -f

## Testing capabilities

# Add the flux user to the git user with write access to the cluster_repo
flux_identity: check_env github_user
	fluxctl identity $(NS_FLAGS)
	echo -e "set this in \n https://github.com/$(GITHUB_USER)flux-get-started/settings/keys/new"

# List all images cached by the fluxctl 
flux_list_images_all:
	fluxctl list-images $(NS_FLAGS)

# defaults to demo ghost for listing
flux_list_images:
	fluxctl list-images $(NS_FLAGS) $(CONTROLLER_FLAGS)

# List all controllers
flux_list_controllers_all:
	fluxctl list-controllers -a $(NS_FLAGS) 

# Update all images based on the current manifest
flux_release_update_all_images:
	fluxctl release $(NS_FLAGS) $(CONTROLLER_FLAGS) --update-all-images

# Update the image manually
flux_release_update_image:
	fluxctl release $(NS_FLAGS) $(CONTROLLER_FLAGS) $(IMAGE_FLAGS) --force

# Update the image based on automation policy
flux_policy_update:
	fluxctl policy $(NS_FLAGS) $(CONTROLLER_FLAGS) $(POLICY_FLAGS)

clean:
	helm delete --purge flux
