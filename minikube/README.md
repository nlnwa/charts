## Prerequisites

### Get latest stable linkerd
 
Linkerd 2 ([Install the cli](https://linkerd.io/2/getting-started/#step-1-install-the-cli)):

```$ curl -sL https://run.linkerd.io/install | sh```

### Install

Initializes helm, installs/upgrades linkerd, installs/upgrades veidemann and sets `veidemann.local` to point to minikube ip in `/etc/hosts`

```bash
$ ./install.sh
```

### Upgrade 

Upgrade veidemann

```bash
$ ./upgrade.sh
```
