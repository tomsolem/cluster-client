# K8s cluster client

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
    docker build . -t cc
    ```

- Get your copy of the kubeconfig and update the path to so you mount the kubeconfig file into the correct path.

    ```bash
    docker run -it --rm -v ${PWD}:/local -v ${HOME}/dev/github/bkk-digitek/kubernetes/ace-test:/src -e KUBECONFIG=/src/kubeconfig.yaml -p 8200:8200 cc
    ```

Ports are to use for port forwarding.
