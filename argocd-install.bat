call kubectl create namespace argocd
call kubectl apply --server-side -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
call kubectl get pods -n argocd -w