FROM alpine:3.10

ENV KUBE_VERSION="v1.16.2"
ENV HELM_VERSION="v3.3.4"
ENV ISTIO_VERSION="1.5.7"
ENV FLUXCD_VERSION="1.19.0"
ENV K9S_VERSION="v0.21.9"
ENV VAULT_VERSION="1.6.0"
#https://get.helm.sh/helm-v3.0.1-linux-amd64.tar.gz
RUN apk add --no-cache ca-certificates bash git openssh curl zsh vim \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm 

RUN wget -q https://github.com/istio/istio/releases/download/${ISTIO_VERSION}/istio-${ISTIO_VERSION}-linux.tar.gz -O - | tar -xzO istio-${ISTIO_VERSION}/bin/istioctl > /usr/local/bin/istioctl \
    && chmod +x /usr/local/bin/istioctl 

RUN wget -q https://github.com/fluxcd/flux/releases/download/${FLUXCD_VERSION}/fluxctl_linux_amd64 -O fluxctl \
    && cp fluxctl /usr/local/bin/ \
    && chmod +x /usr/local/bin/fluxctl 

RUN wget -q https://github.com/derailed/k9s/releases/download/v0.21.9/k9s_Linux_arm64.tar.gz -O - | tar -xzO k9s > /usr/local/bin/k9s \
    && chmod +x /usr/local/bin/k9s

RUN wget -q https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

RUN apk add vault

RUN cp /usr/sbin/vault /usr/local/bin

COPY .zshrc /root/.zshrc
WORKDIR /config

CMD ["zsh"]