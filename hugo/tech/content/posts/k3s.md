---
title: The first node
date: 2025-05-26
draft: false
tags:
    - k8s
    - k3s
    - hardware
---

# Hardware
    The first node we are starting with is a [Zima Blade](https://shop.zimaspace.com/products/zimablade-single-board-server-for-cyber-native). I originally purchased this to make a cheap NAS; however, that proved to be too much for this little guy. Software wise it was fine; however, it doesn't provide enough power for multiple HDD's. I lost $100 to a 8tb hdd after about 6 months due to an increasing clicking sound. We have a different set up for the NAS, which I should talk about in a different post. Anyways, after that didn't work I shelved this thing for a while and after getting into K8s, I decided to start a home lab. So far the thing works great. I added their 16 gb stick of ddr3 to it. 
# Operating System
The CasaOS that comes installed is kind of shitty if you ask me. It's cool if you just want to run some docker apps; but as far as I could tell, we weren't going to get anywhere with K8s and this thing. For whatever reason, OS's like this one and notably, True NAS scale, they lock downt he package manager and some of your sudo commands. This wasn't going to work, so I wiped it out and grabbed the newest debian distro. I don't have a reason for choosing debian over ubuntu, arch, nix, or any of those other distros. They all can install k3s fine but debian has a cooler sounding name, so I chose that to match my domain name. Yeah that's the only reason... If you want my advice, I'd probably choose ubuntu if you like copy and pasting commands, but then again, check out the debian logo.![debian logo](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.GOEUYPz3zTEbVPuOsxc1gAHaEo%26pid%3DApi&f=1&ipt=0fb892977a9d140bcecb854b624d453a7b8c1b9dce1c14caa333cd6fcf4f2d64&ipo=images)
# Kubernetes Version
I chose k3s because it's the first one where I got the loadbalancers to work. When I first started building this home lab, I didn't realize that loadbalancers were dished out by the cloud services and weren't going to work for me. I think I started with dockerdesktop, then rancher, then it was k3s. It's not that you can't get the loadbalancers to work on those, it's just that I didn't even know I needed to replace the loadbalancers. I think I got lucky though, because If I would have tried one more, it was going to be minikube. That would have been a bummer because they have a tunnel command that allows bare metal to connect to an external ip, but it's not the same as [metaallb](https://metallb.io/). I'll talk more about this in a different post, but I discorverd mettallb with k3s and I'm pretty happy it worked out this way.
# NAS 
Our NAS is ridiculous. It's a home made case and I had these visions of using 12 hdd's and 7 sdd's. But in fact I have only 4 HDD's running and 1 tb of pci ssd. It's running a raid 5 set up, I think [Truenas](https://www.truenas.com/truenas-scale/) calls it a raid-z1. We got a bunch of 40gb of ddr4 running in there and a graphics card. All just kind of getting wasted... I think I'm going to try and steal some of these resources for my cluster in the futer. I plan to start a debian vm on there and creating a second node for the cluster. Theres more unused resouces there than there is in the 1st node so we could triple our power, if we need it, or it think it would be cool.  

# Getting started
I didn't really take notes on this part. The best thing to do is follow the [instructions](https://docs.k3s.io/quick-start). I'll say the only gotcha I can think of, is some path variables need need to change.

# Extra bits
- K9s
- Istio
    - ingress multiple sub domains to one IP
- CSI-NFS-Driver
- 2 full NGINX Deployment
- PFsense 
- ZSA
- TrueNas Scale
- Hugo
 
