Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-52-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

 * Introducing self-healing high availability clustering for MicroK8s!
   Super simple, hardened and opinionated Kubernetes for production.

     https://microk8s.io/high-availability

154 updates can be installed immediately.
1 of these updates is a security update.
To see these additional updates run: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.
Last login: Wed Nov  4 13:20:30 2020 from 185.58.16.3
vmuser@star:~$ cd docker-compose
-bash: cd: docker-compose: No such file or directory
vmuser@star:~$ docker ps
CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS                                                                    NAMES
44427fcb2d3c        smartsdk/quantumleap:0.7.6   "/bin/sh -c 'python …"   9 hours ago         Up 9 hours          0.0.0.0:8668->8668/tcp                                                   fiware-quantumleap
7d30e7674503        crate:3.3                    "/docker-entrypoint.…"   9 hours ago         Up 9 hours          0.0.0.0:4200->4200/tcp, 0.0.0.0:4300->4300/tcp, 0.0.0.0:5432->5432/tcp   db-crate
3bf07f52fe6a        sandemoproxy:0.1             "/bin/sh -c 'python …"   9 hours ago         Up 9 hours                                                                                   DEMO_SANPROXY
67dce16bb320        fiware/orion:2.3.0           "/usr/bin/contextBro…"   9 hours ago         Up 9 hours          0.0.0.0:1026->1026/tcp                                                   dih2_orion_1
2cc360f06f58        fiware/ngsiproxy:1.2         "docker/entrypoint.sh"   9 hours ago         Up 9 hours          0.0.0.0:3000->3000/tcp                                                   dih2_ngsiproxy_1
811c26235a4d        mongo:3.6                    "docker-entrypoint.s…"   9 hours ago         Up 9 hours          27017/tcp                                                                dih2_mongodb_1
a996db3336bf        mongo:3.6                    "docker-entrypoint.s…"   9 hours ago         Up 9 hours          27017/tcp                                                                dih2_mongo_1
vmuser@star:~$
