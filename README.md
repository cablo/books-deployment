# Jak spustit vytvorene dockery z Git Hub v k8s v lokalnim Docker Desktop

## Predpoklad

Aktualni `books-app.yml` se odkazuje na spravne docker images v Git Hub Container Registry se jmeny
`ghcr.io/cablo/books-be:sha-647a7ba` apod.

## Rebuild k8s clusteru v Docker Desktop (DD)

1. Zastavit bezici k8s cluster v DD a nastartovat ho znova.  
   Tim se vytvori cisty a prazdny.
1. Nainstalovat podporu Ingress do k8s: `ingress-install.bat` a chvili pockat
1. Spustit deploy: `kubectl apply -f books-app.yml`
1. Chvili pockat a spustit `ingress-check.bat`, ktery ma ukazat hodnoty v ADDRESS a PORT pro 2 Ingressy (backend a
   frontend)
1. Pokud je vse OK, aplikace bezi na [http://localhost:80](http://localhost).  
   Ingress spravne routuje vse zacinajici na `/api` do `backend-service` a ostatni do `frontend-service`.

> Pokud je potreba menit neco v Ingress, tak je nejlepsi restartovat cely cluster a zacit bodem 1.
