# Cluster client

Docker image to manage kubernetes cluesters.

## How to

clone this repo. Update version of different tools to use in your cluster.

Build the docker image

```bash
docker build . -t cc
```

Get your copy of the kubeconfig and update the path to so you mount the kubeconfig file into the correct path.

```bash
docker run -it --rm -v ${PWD}:/local -v ${HOME}/dev/github/bkk-digitek/kubernetes/ace-test:/src -e KUBECONFIG=/src/kubeconfig.yaml -p 8200:8200 cc
```

Ports are to use for port forwarding.
