rem Restarts ArgoCD with books-app definition in yaml
call kubectl apply -f books-app-argocd/argocd-books-app-definition.yml
call kubectl get applications -n argocd -w