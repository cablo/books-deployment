# Jak nainstalovat do Azure AKS

1. Zacne se vytvorenim Resource Group (v tom je vsechno):  
   `az group create --name books-app-resource-group --location polandcentral`
1. Nastavit, ze chceme pouzivat k8s:  
   `az provider register --namespace Microsoft.ContainerService`
1. Vytvorit cluster:  
   `az aks create --resource-group books-app-resource-group --name books-app-cluster --node-count 1 --node-vm-size Standard_B2s_v2 --generate-ssh-keys`
1. Propojeni kubectl:    
   `az aks get-credentials --resource-group books-app-resource-group --name books-app-cluster`   
   `kubectl cluster-info`  
   `kubectl get nodes`
1. Instalace Ingress: stejne helm prikazy jako v AWS
1. Instalace ArgoCD: stejne jako v AWS - instalace, tunel, gui  
1. Nainstalovani aplikace do Arga (do bezici aplikace se vleze pres gui frontend-ingress a ikonka s sipkou):  
   `kubectl apply -f books-app-argocd/argocd-books-app-azure.yml`

### Smazani clusteru
>`az aks delete --resource-group books-app-resource-group --name books-app-cluster`  
>`az group delete --name NetworkWatcherRG --yes`  
>`az group delete --name books-app-resource-group`  
Podivat se do "Resource Groups" a promazat to rucne, napr "NetworkWatcherRG"