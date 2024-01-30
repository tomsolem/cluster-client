alias=ct='docker run -it --rm -v ${HOME}/.ssh:/root/.ssh:ro -v ${PWD}:/local -v ${HOME}/dev/github/bkk-digitek/kubernetes/ace-test:/src -e KUBECONFIG=/src/kubeconfig.yaml -e FLUX_FORWARD_NAMESPACE=fluxcd -p 8200:8200 cc'
alias=cp='docker run -it --rm -v ${HOME}/.ssh:/root/.ssh:ro -v ${PWD}:/local -v ${HOME}/dev/github/bkk-digitek/kubernetes/ace-test:/src -e KUBECONFIG=/src/kubeconfig.yaml -e FLUX_FORWARD_NAMESPACE=fluxcd -p 8200:8200 cc-prod'

auto complete 
https://gist.github.com/GusAntoniassi/2f58e716b67f648d13f91c1d780b05bf



az aks get-credentials --resource-group ASK-workshop --name msworkshop -a kubconfig.yaml