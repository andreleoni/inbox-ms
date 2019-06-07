#!/bin/sh

rake docker:push_image

kubectl create secret generic secret-key-base --from-literal=secret-key-base=50dae16d7d1403e175ceb2461605b527cf87a5b18479740508395cb3f1947b12b63bad049d7d1545af4dcafa17a329be4d29c18bd63b421515e37b43ea43df64

kubectl create -f kube/services/redis_svc.yaml
kubectl create -f kube/deployments/redis_deploy.yaml

bundle exec rake docker:push_image

kubectl create -f kube/services/rails_svc.yaml

kubectl create -f kube/deployments/rails_deploy.yaml

kubectl create -f kube/ingresses/ingress.yaml
