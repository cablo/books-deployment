# Amazon Linux:

Pripojeni:
(soubor klice musi mit v security jen aktualniho usera s Cist/Zapisovat; nic jineho)
>ssh -i "books-app.pem" ec2-user@<IP-ADRESA-INSTANCE>
      
Nastaveni Swapu:
>sudo dd if=/dev/zero of=/swapfile bs=1M count=1024  
sudo chmod 600 /swapfile  
sudo mkswap /swapfile  
sudo swapon /swapfile  
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

Instalace k3s:
>curl -sfL https://get.k3s.io | sh -s - server \
--disable traefik \
--disable local-storage \
--disable metrics-server \
--kube-apiserver-arg="max-requests-inflight=50" \
--kube-apiserver-arg="max-mutating-requests-inflight=20"

Start aplikace:
>sudo kubectl apply -f books-app.yaml

Deinstalace k3s:
>sudo /usr/local/bin/k3s-uninstall.sh