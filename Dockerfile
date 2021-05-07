FROM alpine:3.10

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

RUN apk add --no-cache ca-certificates bash git openssh curl zsh vim jq \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm 

RUN wget -q https://github.com/istio/istio/releases/download/${ISTIO_VERSION}/istio-${ISTIO_VERSION}-linux-amd64.tar.gz -O - | tar -xzO istio-${ISTIO_VERSION}/bin/istioctl > /usr/local/bin/istioctl \
    && chmod +x /usr/local/bin/istioctl 

RUN wget -q https://github.com/fluxcd/flux/releases/download/${FLUXCD_VERSION}/fluxctl_linux_amd64 -O fluxctl \
    && cp fluxctl /usr/local/bin/ \
    && chmod +x /usr/local/bin/fluxctl 

RUN wget -q https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-amd64 -O argocd \
    && cp argocd /usr/local/bin/ \
    && chmod +x /usr/local/bin/argocd

RUN wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 -O /usr/local/bin/yq &&\
    chmod +x /usr/local/bin/yq

RUN wget -q https://github.com/derailed/k9s/releases/download/v0.24.6/k9s_Linux_x86_64.tar.gz -O - | tar -xzO k9s > /usr/local/bin/k9s \
    && chmod +x /usr/local/bin/k9s

RUN wget -q https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

RUN wget -q https://github.com/cli/cli/releases/download/v${GITHUB_CLI_VERSION}/gh_${GITHUB_CLI_VERSION}_linux_amd64.tar.gz -O gh_${GITHUB_CLI_VERSION}_linux_amd64.tar.gz
RUN tar xvf gh_${GITHUB_CLI_VERSION}_linux_amd64.tar.gz
RUN cp gh_${GITHUB_CLI_VERSION}_linux_amd64/bin/gh /usr/local/bin/

RUN wget -q https://github.com/wercker/stern/releases/download/${STERN_VERSION}/stern_linux_amd64  -O stern_linux_amd64
RUN chmod +x stern_linux_amd64
RUN mv stern_linux_amd64 /usr/local/bin/stern


RUN apk add vault

RUN cp /usr/sbin/vault /usr/local/bin

COPY .zshrc /root/.zshrc
WORKDIR /config

CMD ["zsh"]