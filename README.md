# flux-get-started

We published a step-by-step run-through on how to use Flux and Helm Operator
* [Helm getting started](https://github.com/weaveworks/flux/blob/master/site/helm-get-started.md).
* [Kubectl details about fluxctl](https://github.com/weaveworks/flux/blob/master/site/fluxctl.md)
* [Annotations](https://github.com/weaveworks/flux/blob/master/site/annotations-tutorial.md)

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

Mongodb
* Source: Helm repository (stable)
* Kubernetes deployment
* automated image updates (semantic versioning filter)

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
