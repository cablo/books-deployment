# Jak nainstalovat do AWS EKS

1. Spustit instalaci maleho clusteru  
   `eksctl create cluster --name books-app-eks --region eu-north-1 --node-type t3.medium --nodes 2 --nodes-min 1 --nodes-max 2`  
   Sledovat CloudFormation > Stacks na webu, jak se to vytvari. Mel by nabehnout EKS Cluster a 2x EC2 instance.
1. Po vytvoreni radeji rucne presmerovat `kubectl` do AWS  
   `aws eks update-kubeconfig --region eu-north-1 --name books-app-eks`
1. Nainstalovat Ingress Nginx  
   `helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx`  
   `helm repo update`  
   `helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace`  
   `kubectl get service -n ingress-nginx ingress-nginx-controller`
1. Nastravit vsem Workerum (EC2 instance) roli, aby mohly pristupovat k EBS disku:    
   Vyhledat nazev IAM role: Otevrit detail Workeru z EC2 -> Security -> IAM Role -> zkopirovatj eji nazev a vlozit do nasledujiciho prikazu 
   `aws iam attach-role-policy --role-name <<<eksctl-books-app-eks-nodegroup-ngXXXXXXXXX>>> --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy`
1. Nainstalovat vlastni ovladac EBS disku pro Postgress:  
   `eksctl create addon --name aws-ebs-csi-driver --cluster books-app-eks --region eu-north-1`
1. Nainstalovat ArgoCD stejne jako na lokalu, spustit:  
   `kubectl create namespace argocd`  
   `kubectl apply --server-side -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml`
1. Spustit tunel do ArgoCD a zjistit login do ArgoCD:  
   `argocd-tunnel.ps1`  
   Pripojit se do GUI ArgoCD  
1. Aktualizovat aplikaci do ArgoCD, ktera se pripoji do Gitu a spusti Helm chart odtamtud:  
   `kubectl apply -f books-app-argocd/argocd-books-app-aws.yml`  
