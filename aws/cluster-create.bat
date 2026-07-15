eksctl create cluster --name books-app-eks --region eu-north-1 --node-type t3.medium --nodes 2 --nodes-min 1 --nodes-max 2
rem Pri vytvareni se podivat do CloudFormation, ktery vytvari cely cluster (spravna zona)


rem Presmerovani kubectl do eks
aws eks update-kubeconfig --region eu-north-1 --name books-app-eks
kubectl get pods


rem Instalace ingress nginx
rem Přidání repozitáře
call helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
call helm repo update
rem Instalace do vlastního namespace
call helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace
call kubectl get service -n ingress-nginx ingress-nginx-controller






helm install books-app-helm . -f ./values-aws.yaml






rem Cluster delete
call eksctl delete cluster --name books-app-eks --region eu-north-1