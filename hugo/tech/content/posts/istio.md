---
title: Ingress
date: 2025-05-26
draft: false
tags:
    - k8s
    - k3s
    - ingress
    - istio
    - nginx
    - 
---
# Assumptions
1. Load balancers has it's own IP
2. Deployments running with pods/services
# Documentation
Before getting started on this, it's worth noting there's more than a few ways to do this, which is worth knowing before getting started. I went ahead and went with the [istio sidecar method](https://istio.io/latest/docs/setup/getting-started/), then I used these instructions to [secure the gateway with tls](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/)
# Itio/nginx Pods
```
$ k get pods -n istio-system -o wide
NAME                                    READY   STATUS    RESTARTS   AGE   IP           NODE      NOMINATED NODE   READINESS GATES
istio-ingressgateway-7f7bcf6bb9-kf444   1/1     Running   0          8d    10.42.0.71   tdebian   <none>           <none>
istiod-85c68488c4-94s9v                 1/1     Running   0          8d    10.42.0.70   tdebian   <none>           <none>
```
I had accidentally created a race condition with my servieces below. I created the second one off the 1st one, but forgot to change one of my labels. This meant I had 2 services both navigating traffic to both pods.
```
$ k get all -n hugo
NAME                              READY   STATUS    RESTARTS   AGE
pod/nginx-hugo-946ff545b-2mclc    2/2     Running   0          5h21m
pod/nginx-tech-7449666dd7-d9q9r   2/2     Running   0          5h20m

NAME                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
service/nginx-svc-hugo   ClusterIP   10.43.213.158   <none>        80/TCP    5h21m
service/nginx-svc-tech   ClusterIP   10.43.88.164    <none>        80/TCP    5h20m

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-hugo   1/1     1            1           5h21m
deployment.apps/nginx-tech   1/1     1            1           5h20m

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-hugo-946ff545b    1         1         1       5h21m
replicaset.apps/nginx-tech-7449666dd7   1         1         1       5h20m
```
I an into a gotcha with the secrets. For the most part you can follow the instructions; however, the secrets need to be in the istio-system namespace. I had put it into the namespace with my deployments, I was thinking it the gateway used it, but I'm guessing it must be the istio-ingressgateway pod. I didn't have tls encryption till that was complete. Right now we have transport layer security encryption; however, since it's self signed by me... It still says the site is unsafe. ##TODO Get better keys/crts, or certificate manager.
```
NAME               TYPE                DATA   AGE
istio-ca-secret    istio.io/ca-root    5      8d
tblog-credential   kubernetes.io/tls   2      7h3m
tech-credential    kubernetes.io/tls   2      7h1m
```
Alright so my gateway. I started off with the example from istio, then I started changing one thing at a time. I started by manipulating some port numbers, then I changed to a blank NGINX deployment. There's a few different options under tls, right now we only have simple, ##TODO figure out why we might want mutual or terminated. Then eventually, I got to where I was reading the tables of what was and was not needed. 
```yaml
apiVersion: networking.istio.io/v1
kind: Gateway
metadata:
  name: nginx-gateway
  namespace: hugo
spec:
  selector:
    istio: ingressgateway
  servers:
    - port:
        number: 443
        name: https-tblog
        protocol: HTTPS
      tls:
        mode: SIMPLE
        credentialName: tblog-credential
      hosts:
        - "tblog.tdebian.com"
    - port:
        number: 443
        name: https-tech
        protocol: HTTPS
      tls:
        mode: SIMPLE
        credentialName: tech-credential
      hosts:
        - "tech.tdebian.com"
    - port:
        number: 80
        name: http-tblog
        protocol: HTTP
      hosts:
        - "tblog.tdebian.com"
    - port:
        number: 80
        name: http-tech
        protocol: HTTP
      hosts:
        - "tech.tdebian.com"
```
At this point in time I only needed to route traffic based on the host in the header. So, I was eventually able to remove most of the match block. That route host address threw me for a loop for a while. There's supposed to be a way for you to write this in shorthand, but it was not working for me. According to the docs I should have been able to leave this as just the svc name, but I found that I was not recieving traffic with it like that. 
```yaml
apiVersion: networking.istio.io/v1
kind: VirtualService
metadata:
  name: tblogtdebian
  namespace: hugo
spec:
  hosts:
    - "tblog.tdebian.com"
  gateways:
    - nginx-gateway
  http:
    - route:
        - destination:
            host: nginx-svc-hugo.hugo.svc.cluster.local
```




