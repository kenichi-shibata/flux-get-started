# flux-get-started

Start here
* [Helm based](https://github.com/fluxcd/flux/blob/master/docs/tutorials/get-started-helm.md)
* [Kustomized Based](https://github.com/fluxcd/flux/blob/master/docs/tutorials/get-started-kustomize.md)
* [Kubectl Native based](https://github.com/fluxcd/flux/blob/master/docs/tutorials/get-started.md)

We published a step-by-step run-through on how to use Flux and Helm Operator
* [Helm getting started](https://github.com/fluxcd/flux/blob/master/docs/references/helm-operator-integration.md).
* [Kubectl details about fluxctl](https://github.com/fluxcd/flux/blob/master/docs/references/fluxctl.md)
* [Annotations](https://docs.fluxcd.io/en/1.19.0/references/helm-operator-integration/#annotations)

Some related topics 
* [Walkthrough podinfo](https://github.com/stefanprodan/k8s-podinfo/blob/master/docs/1-deploy.md)
* [Prometheus HPA](https://github.com/stefanprodan/k8s-prom-hpa)
* [More example how to structure cluster repo](https://github.com/stefanprodan/gitops-helm/)
* [Flagger Canary](https://docs.flagger.app/install/install-istio)
### Workloads

podinfo
* Kubernetes deployment, ClusterIP service and Horizontal Pod Autoscaler
* init container automated image updates (regular expression filter)
* container automated image updates (semantic versioning filter)

### Helm releases

Redis
* Source: Helm repository (stable)
* Kubernetes stateful set 
* locked automated image updates (semantic versioning filter)

Ghost
* Source: Git repository
* disabled automated image updates (glob filter)
* has external dependency - mariadb (stable)

## <a name="help"></a>Getting Help

If you have any questions about, feedback for or problems with `flux-get-started`:

- Invite yourself to the <a href="https://slack.weave.works/" target="_blank">Weave Users Slack</a>.
- Ask a question on the [#flux](https://weave-community.slack.com/messages/flux/) slack channel.
- [File an issue](https://github.com/weaveworks/flux-get-started/issues/new).

Your feedback is always welcome!
