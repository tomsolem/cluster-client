# Kubernetes cluster client

Docker image to manage kubernetes cluesters. Run the same version on "client"
as on the "server" side of the cloud. 😊

## Tools installed in docker image

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Helm](https://helm.sh/docs/intro/install/)
- [Fluxcd](https://fluxcd.io/)
- [Istio](https://istio.io/)
- [k9s](https://k9scli.io/)
- [ArgoCD cli](https://github.com/argoproj/argo-cd)
- [yq tool](https://github.com/mikefarah/yq)
- [Github cli](https://github.com/cli/cli)
- [Stern](https://github.com/wercker/stern)

## 🤷‍♂️ HowTo

- Clone this repo.
- Update version of different tools to use in your cluster in the Dockerfile:

    ```dockerfile
    ENV KUBE_VERSION="v1.19.9"
    ENV HELM_VERSION="v3.3.4"
    ENV ISTIO_VERSION="1.8.2"
    ENV FLUXCD_VERSION="1.19.0"
    ENV K9S_VERSION="v0.21.9"
    ENV VAULT_VERSION="1.6.0"
    ENV ARGOCD_VERSION="v1.8.3"
    ENV YQ_VERSION="v4.6.3"
    ENV GITHUB_CLI_VERSION="1.9.2"
    ENV STERN_VERSION="1.11.0"
    ```

- ⚙️ Build the docker image

    ```bash
    docker build . -t clusterclient
    ```

- Get your copy of the kubeconfig and update the path to so you mount the kubeconfig file into the correct path.
  I.e. your local kubeconfig file is stored in `/${HOME}/dev/config.yaml`. Change the mount path to your local path
  and update the environment variable to point to the correct configuration file.

    ```bash
    docker run -it --rm -v "${HOME}/.ssh:/root/.ssh:ro" -v "${PWD}:/local" -v "${HOME}/dev/github/bkk-digitek/kubernetes/ace-common-01:/src" -e KUBECONFIG=/src/kubeconfig.yaml -e FLUX_FORWARD_NAMESPACE=fluxcd -p 8200:8200 -p 8080:8080 clusterclient
    ```

- Ports are to use for [port forwarding](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/).
- Run multiple version of the image with alias in .zshrc config file
  
  ```bash
  alias kt='docker run -it --rm -v "${HOME}/.ssh:/root/.ssh:ro" -v "${PWD}:/local" -v "${HOME}/dev/github/bkk-digitek/kubernetes/ace-common-01:/src" -e KUBECONFIG=/src/kubeconfig.yaml -e FLUX_FORWARD_NAMESPACE=fluxcd -p 8200:8200 -p 8080:8080 clusterclient'
  ```

## ☭ Tools

Tips and tricks on using the tools

### Stern

Read logs from more than one pod in once:

```.bash
stern "regex" --tail=300 --container golang --namespace my-ns
```

### k9s

run k9s and get a nice view of you cluster.

TODO: se az-pipeline-container to push to docker hub