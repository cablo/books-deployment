$secret = kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}'
$heslo = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($secret))
Write-Host "Login do ArgoCD (https://localhost:8080) je: admin / $heslo"

# Creates tunnel for https://localhost:8080
kubectl port-forward svc/argocd-server -n argocd 8080:443