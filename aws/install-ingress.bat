rem Přidání repozitáře
call helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
call helm repo update

rem Instalace do vlastního namespace
call helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace
call kubectl get service -n ingress-nginx ingress-nginx-controller


rem EBS CSI driver — ovladač pro disky (pro PersistentVolume PostgreSQL)
rem --use-default-roles nestačilo: node instance role neměla AmazonEBSCSIDriverPolicy, EBS CSI controller nemohl volat EC2 API
rem Oprava: ručně připojit policy k node instance roli:
rem   1) zjistit jméno role: aws cloudformation describe-stack-resources --stack-name eksctl-books-app-eks-nodegroup-ng-... | findstr NodeInstanceRole
rem      nebo: eksctl get nodegroup --cluster books-app-eks --region eu-north-1
rem   2) připojit policy: aws iam attach-role-policy --role-name <node-instance-role> --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy
eksctl create addon --name aws-ebs-csi-driver --cluster books-app-eks --region eu-north-1 --use-default-roles


rem helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace --timeout 20m