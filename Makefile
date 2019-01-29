.PHONY: clean helm_install_tiller helm_repo_add helm_install_flux_crd helm_install_flux

check_env:
	which git &> /dev/null || (echo "please install git"; exit 1)
	which helm &> /dev/null || (echo "please install helm"; exit 1)
	which kubectl &> /dev/null || (echo "please install kubectl"; exit 1)

github_user:
ifndef GITHUB_USER
	$(error GITHUB_USER is undefined)
endif

helm_install_tiller: check_env
	kubectl -n kube-system create serviceaccount tiller \
	kubectl create clusterrolebinding tiller-cluster-rule \
    --clusterrole=cluster-admin \
    --serviceaccount=kube-system:tiller \
	helm init --skip-refresh --upgrade --service--accout --tiller

helm_repo_add: check_env
	helm repo add weaveworks https://weaveworks.github.io/flux

helm_install_flux_crd: check_env
	kubectl apply -f https://raw.githubusercontent.com/weaveworks/flux/master/deploy-helm/flux-helm-release-crd.yaml

helm_install_flux: check_env github_user
	helm upgrade -i flux \
	--set helmOperator.create=true \
	--set helmOperator.createCRD=false \
	--set git.url=git@github.com:$(GITHUB_USER)/flux-get-started \
	--namespace flux \
	weaveworks/flux

clean:
	helm delete --purge flux
