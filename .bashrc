if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin:$HOME/.fastlane/bin"

export LC_ALL="fr_FR.UTF-8"
export LANG="fr_FR.UTF-8"

dev_pull_all() {
  for dir in $(ls ~/cinqs/ | grep -E '^(us|ws)\-')
  do
    cd ~/cinqs/$dir && git co develop && git pull
  done
}

forallprojects () {
  for project in $(ls ~/cinqs-workspace/ | grep -E '^(us|ws|node)\-') ; do ( echo -e "\n\n< ********** "$project" ********** >" && cd $project && $1 ); done
  cd ~/cinqs-workspace
}

# kubernetes
kbash() {
  kubectl exec -it $1 /bin/bash
}
ksh() {
  kubectl exec -it $1 /bin/sh
}
klogs() {
  kubectl logs $1
}
klogsall() {
  for pod in $(kubectl get --no-headers=true pods -o custom-columns=:metadata.name); do echo "<------------------------ ${pod} ------------------------>" && kubectl logs ${pod}; done  
}
kdeps() {
  kubectl get deployments $1
}
kpods() {
  kubectl get pods -o=wide $1
}
kserv() {
  kubectl get services $1
}
knodes() {
  kubectl get nodes
}
ktop() {
  kubectl top nodes
  kubectl top pods
}
kprod() {
  ~/cinqs/prod
  #gcloud config configurations activate cinqs-production
  #gcloud container clusters get-credentials uss-cluster
}
kdev() {
  ~/cinqs/staging
  #gcloud config configurations activate cinqs-development
  #gcloud container clusters get-credentials uss-cluster
}
kmini() {
  kubectl config use-context minikube
}
kcurrent() {
  kubectl config current-context
}

timestamp() {
  date +%s
}

