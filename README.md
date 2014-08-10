airvideo-server
===============

docker file to setup airvideo server on ubuntu

setup
--------

```
docker pull menghan/airvideo-server-in-docker
docker run -d --name airvideo-runner -u user -p 45631:45631 -p 46631:46631 -v /path/to/my/movies:/Movies menghan/airvideo-server-in-docker
```

note
-----

1. This doesnot work on OSX, because docker on OSX is running in virtual machine(via boot2docker), ports are binded inside virtual machine, and volumns are searched inside virtual machine too.
