# Jak nainstalovat do AWS EKS

1. Spustit instalaci maleho clusteru  
   `create cluster --name books-app-eks --region eu-north-1 --node-type t3.medium --nodes 2 --nodes-min 1 --nodes-max 2`  
   Sledovat CloudFormation > Stacks na webu, jak se to vytvari. Mel by nabehnout EKS Cluster a 2x EC2 instance.
1. Po vytvoreni radeji rucne presmerovat `kubectl` do AWS  
   `aws eks update-kubeconfig --region eu-north-1 --name books-app-eks`  
1. Nainstalovat Ingress Nginx  
   `helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx`  
   `helm repo update`  
   `helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace`  
   `kubectl get service -n ingress-nginx ingress-nginx-controller`
1. Nainstalovat ArgoCD stejne jako na lokalu, spustit  
   `argocd-install.bat`  
2. 
3. 
4. Spustit deploy: `kubectl apply -f books-app.yml`
1. Chvili pockat a spustit `ingress-check.bat`, ktery ma ukazat hodnoty v ADDRESS a PORT pro 2 Ingressy (backend a
   frontend)
1. Pokud je vse OK, aplikace bezi na [http://localhost:80](http://localhost).  
   Ingress spravne routuje vse zacinajici na `/api` do `backend-service` a ostatni do `frontend-service`.

> Pokud je potreba menit neco v Ingress, tak je nejlepsi restartovat cely cluster a zacit bodem 1.


## Pouziti s ArgoCD

1. Nastartovat k8s a nainstalovat Ingress `ingress-install.bat`
1. Nainstalovat ArgoCD `argocd-install.bat` (v k9s je pak videt namespace argocd)
1. Spustit ArgoCD tunel `argocd-tunnel.ps1`, ktery zpristupni jejich UI
1. Otevrit jejich UI podle vypsane url a loginu 
1. Spustit App v ArgoCD `argocd-set-app.bat` -> zalozi to aplikaci v ArgoCD, ktera uz se synchronizuje s Gitem a sama se opravuje
1. Otestovani SelfHeal -> spustit `k9s`, zobrazit Deployment Backendu (:, deploy, tab, enter) a na backendu stisknout `s` a zmenit pocet replik. Na chvili se zmeni, ale pak se vrati do stavu ArgaCD   

