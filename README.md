# Kubernetes cluster client

Docker image to manage kubernetes cluesters.

## Tools installed in docker image

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Helm](https://helm.sh/docs/intro/install/)
- [Fluxcd](https://fluxcd.io/)
- [Istio](https://istio.io/)
- [k9s](https://k9scli.io/)

## HowTo

- Clone this repo.
- Update version of different tools to use in your cluster in the Dockerfile:

    ```dockerfile
    ENV KUBE_VERSION="v1.16.2"
    ENV HELM_VERSION="v2.15.0"
    ENV ISTIO_VERSION="1.5.7"
    ENV FLUXCD_VERSION="1.19.0"
    ENV K9S_VERSION="v0.21.9"
    ```

- Build the docker image

    ```bash
    docker build . -t ccHelm3
    ```

- Get your copy of the kubeconfig and update the path to so you mount the kubeconfig file into the correct path.
  I.e. your local kubeconfig file is stored in `/${HOME}/dev/config.yaml`. Change the mount path to your local path
  and update the environment variable to point to the correct configuration file.

    ```bash
        docker run -it --rm -v "${HOME}/.ssh:/root/.ssh:ro" -v "${PWD}:/local" -v "${HOME}/dev/github/bkk-digitek/kubernetes/ace-common-01:/src" -e KUBECONFIG=/src/kubeconfig.yaml -e FLUX_FORWARD_NAMESPACE=fluxcd -p 8200:8200 -p 8080:8080 cchelm3
    ```

- Ports are to use for [port forwarding](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/).
- Run multiple version of the image with alias in .zshrc config file
  
  ```bash
    alias kt='    docker run -it --rm -v "${HOME}/.ssh:/root/.ssh:ro" -v "${PWD}:/local" -v "${HOME}/dev/github/bkk-digitek/kubernetes/ace-common-01:/src" -e KUBECONFIG=/src/kubeconfig.yaml -e FLUX_FORWARD_NAMESPACE=fluxcd -p 8200:8200 -p 8080:8080 cchelm3'


  ```
