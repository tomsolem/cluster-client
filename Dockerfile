FROM alpine:3.18

ENV KUBE_VERSION="v1.30.10"
# https://github.com/helm/helm/releases
ENV HELM_VERSION="v3.17.2" 
# https://github.com/fluxcd/flux2/releases
ENV FLUXCD_VERSION="2.5.1"
# https://github.com/derailed/k9s/releases
ENV K9S_VERSION="v0.40.10"
# https://github.com/mikefarah/yq/releases
ENV YQ_VERSION="v4.45.1"
# https://github.com/cli/cli/releases
ENV GITHUB_CLI_VERSION="2.69.0"
# https://github.com/stern/stern/releases
ENV STERN_VERSION="1.32.0"
# https://github.com/hashicorp/terraform/releases
ENV TERRAFORM_VERSION="1.11.3"

RUN apk add --no-cache ca-certificates bash git openssh curl zsh vim jq python3 py3-pip gcc musl-dev python3-dev libffi-dev openssl-dev cargo make 
RUN ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
# RUN pip install --upgrade pip
RUN pip install azure-cli

#RUN wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
#    && chmod +x /usr/local/bin/kubectl

RUN wget -q https://dl.k8s.io/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm 
# wget -q https://github.com/fluxcd/flux2/releases/download/v2.1.2/flux_2.1.2_darwin_amd64.tar.gz -O - | tar -xz flux > /usr/local/bin/flux \
RUN wget -q https://github.com/fluxcd/flux2/releases/download/v${FLUXCD_VERSION}/flux_${FLUXCD_VERSION}_linux_amd64.tar.gz -O  - | tar -xzO flux > /usr/local/bin/flux \
    && chmod +x /usr/local/bin/flux

RUN wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 -O /usr/local/bin/yq &&\
    chmod +x /usr/local/bin/yq

RUN wget -q https://github.com/derailed/k9s/releases/download/v0.24.6/k9s_Linux_x86_64.tar.gz -O - | tar -xzO k9s > /usr/local/bin/k9s \
    && chmod +x /usr/local/bin/k9s

# RUN wget -q https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
# Uses "robbyrussell" theme (original Oh My Zsh theme), with no plugins
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t robbyrussell

RUN wget -q https://github.com/cli/cli/releases/download/v${GITHUB_CLI_VERSION}/gh_${GITHUB_CLI_VERSION}_linux_amd64.tar.gz -O gh_${GITHUB_CLI_VERSION}_linux_amd64.tar.gz
RUN tar xvf gh_${GITHUB_CLI_VERSION}_linux_amd64.tar.gz
RUN cp gh_${GITHUB_CLI_VERSION}_linux_amd64/bin/gh /usr/local/bin/

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN chmod +x terraform
RUN mv terraform /usr/local/bin/terraform

RUN apk add vault

RUN cp /usr/sbin/vault /usr/local/bin

COPY .zshrc /root/.zshrc
WORKDIR /config

CMD ["zsh"]