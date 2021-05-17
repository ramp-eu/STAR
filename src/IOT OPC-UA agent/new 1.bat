vmuser@star:~$ docker ps
CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS                                                                    NAMES
44427fcb2d3c        smartsdk/quantumleap:0.7.6   "/bin/sh -c 'python …"   9 hours ago         Up 9 hours          0.0.0.0:8668->8668/tcp                                                   fiware-quantumleap
7d30e7674503        crate:3.3                    "/docker-entrypoint.…"   9 hours ago         Up 9 hours          0.0.0.0:4200->4200/tcp, 0.0.0.0:4300->4300/tcp, 0.0.0.0:5432->5432/tcp   db-crate
3bf07f52fe6a        sandemoproxy:0.1             "/bin/sh -c 'python …"   9 hours ago         Up 9 hours                                                                                   DEMO_SANPROXY
67dce16bb320        fiware/orion:2.3.0           "/usr/bin/contextBro…"   9 hours ago         Up 9 hours          0.0.0.0:1026->1026/tcp                                                   dih2_orion_1
2cc360f06f58        fiware/ngsiproxy:1.2         "docker/entrypoint.sh"   9 hours ago         Up 9 hours          0.0.0.0:3000->3000/tcp                                                   dih2_ngsiproxy_1
811c26235a4d        mongo:3.6                    "docker-entrypoint.s…"   9 hours ago         Up 9 hours          27017/tcp                                                                dih2_mongodb_1
a996db3336bf        mongo:3.6                    "docker-entrypoint.s…"   9 hours ago         Up 9 hours          27017/tcp                                                                dih2_mongo_1
vmuser@star:~$ vmuser@star:~$ docker ps
vmuser@star:~$: command not found
vmuser@star:~$ CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS                                                                    NAMES
CONTAINER: command not found
vmuser@star:~$ 44427fcb2d3c        smartsdk/quantumleap:0.7.6   "/bin/sh -c 'python …"   9 hours ago         Up 9 hours          0.0.0.0:8668->8668/tcp                                                   fiware-quantumleap
-bash: 8668/tcp: No such file or directory
vmuser@star:~$ 7d30e7674503        crate:3.3                    "/docker-entrypoint.…"   9 hours ago         Up 9 hours          0.0