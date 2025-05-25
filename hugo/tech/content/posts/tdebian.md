---
title: How the site works
date: 2025-05-10
draft: false
tags:
    - tech
    - k8s
---

# Hardware
zima blade
# Operating system
debian
# K8s
k3s
# cluster information 
```
$ k get all -A
NAMESPACE        NAME                                          READY   STATUS      RESTARTS         AGE
hugo             pod/nginx-hugo-946ff545b-5vzgj                2/2     Running     0                6d1h
hugo             pod/nginx-tech-f968c6476-kwtkc                2/2     Running     0                6d1h
istio-system     pod/istio-ingressgateway-7f7bcf6bb9-kf444     1/1     Running     0                6d7h
istio-system     pod/istiod-85c68488c4-94s9v                   1/1     Running     0                6d7h
kube-system      pod/coredns-697968c856-48xpf                  1/1     Running     2 (6d22h ago)    20d
kube-system      pod/csi-nfs-controller-8fdc6755d-tgsvb        5/5     Running     13 (6d22h ago)   20d
kube-system      pod/csi-nfs-node-mnxn4                        3/3     Running     7 (6d22h ago)    20d
kube-system      pod/helm-install-traefik-crd-swzq8            0/1     Completed   0                20d
kube-system      pod/helm-install-traefik-jjmsw                0/1     Completed   1                20d
kube-system      pod/local-path-provisioner-774c6665dc-pcb9s   1/1     Running     2 (6d22h ago)    20d
kube-system      pod/metrics-server-6f4c6675d5-s5lfh           1/1     Running     2 (6d22h ago)    20d
kube-system      pod/traefik-c98fdf6fb-7qrnl                   1/1     Running     2 (6d22h ago)    20d
metallb-system   pod/controller-bb5f47665-h2vvv                1/1     Running     2 (6d22h ago)    20d
metallb-system   pod/speaker-8wvfg                             1/1     Running     1 (6d22h ago)    20d

NAMESPACE        NAME                              TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)                                      AGE
default          service/kubernetes                ClusterIP      10.43.0.1       <none>          443/TCP                                      20d
hugo             service/nginx-svc-hugo            ClusterIP      10.43.183.214   <none>          80/TCP                                       6d6h
hugo             service/nginx-svc-tech            ClusterIP      10.43.173.197   <none>          80/TCP                                       6d1h
istio-system     service/istio-ingressgateway      LoadBalancer   10.43.239.90    192.168.1.246   15021:31947/TCP,80:32214/TCP,443:31890/TCP   6d7h
istio-system     service/istiod                    ClusterIP      10.43.217.71    <none>          15010/TCP,15012/TCP,443/TCP,15014/TCP        6d7h
kube-system      service/kube-dns                  ClusterIP      10.43.0.10      <none>          53/UDP,53/TCP,9153/TCP                       20d
kube-system      service/metrics-server            ClusterIP      10.43.169.122   <none>          443/TCP                                      20d
kube-system      service/traefik                   LoadBalancer   10.43.23.114    192.168.1.245   80:30177/TCP,443:32203/TCP                   20d
metallb-system   service/metallb-webhook-service   ClusterIP      10.43.192.243   <none>          443/TCP                                      20d

NAMESPACE        NAME                          DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system      daemonset.apps/csi-nfs-node   1         1         1       1            1           kubernetes.io/os=linux   20d
metallb-system   daemonset.apps/speaker        1         1         1       1            1           kubernetes.io/os=linux   20d

NAMESPACE        NAME                                     READY   UP-TO-DATE   AVAILABLE   AGE
hugo             deployment.apps/nginx-hugo               1/1     1            1           6d6h
hugo             deployment.apps/nginx-tech               1/1     1            1           6d1h
istio-system     deployment.apps/istio-ingressgateway     1/1     1            1           6d7h
istio-system     deployment.apps/istiod                   1/1     1            1           6d7h
kube-system      deployment.apps/coredns                  1/1     1            1           20d
kube-system      deployment.apps/csi-nfs-controller       1/1     1            1           20d
kube-system      deployment.apps/local-path-provisioner   1/1     1            1           20d
kube-system      deployment.apps/metrics-server           1/1     1            1           20d
kube-system      deployment.apps/traefik                  1/1     1            1           20d
metallb-system   deployment.apps/controller               1/1     1            1           20d

NAMESPACE        NAME                                                DESIRED   CURRENT   READY   AGE
hugo             replicaset.apps/nginx-hugo-946ff545b                1         1         1       6d6h
hugo             replicaset.apps/nginx-hugo-f968c6476                0         0         0       6d1h
hugo             replicaset.apps/nginx-tech-f968c6476                1         1         1       6d1h
istio-system     replicaset.apps/istio-ingressgateway-7f7bcf6bb9     1         1         1       6d7h
istio-system     replicaset.apps/istiod-85c68488c4                   1         1         1       6d7h
istio-system     replicaset.apps/istiod-86b6b7ff7                    0         0         0       6d7h
kube-system      replicaset.apps/coredns-697968c856                  1         1         1       20d
kube-system      replicaset.apps/csi-nfs-controller-8fdc6755d        1         1         1       20d
kube-system      replicaset.apps/local-path-provisioner-774c6665dc   1         1         1       20d
kube-system      replicaset.apps/metrics-server-6f4c6675d5           1         1         1       20d
kube-system      replicaset.apps/traefik-c98fdf6fb                   1         1         1       20d
metallb-system   replicaset.apps/controller-bb5f47665                1         1         1       20d

NAMESPACE      NAME                                                       REFERENCE                         TARGETS       MINPODS   MAXPODS   REPLICAS   AGE
istio-system   horizontalpodautoscaler.autoscaling/istio-ingressgateway   Deployment/istio-ingressgateway   cpu: 7%/80%   1         5         1          6d7h
istio-system   horizontalpodautoscaler.autoscaling/istiod                 Deployment/istiod                 cpu: 1%/80%   1         5         1          6d7h

NAMESPACE     NAME                                 STATUS     COMPLETIONS   DURATION   AGE
kube-system   job.batch/helm-install-traefik       Complete   1/1           47s        20d
kube-system   job.batch/helm-install-traefik-crd   Complete   1/1           44s        20d
```
