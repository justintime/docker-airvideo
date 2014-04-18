airvideo-server
===============

docker file to setup airvideo server on ubuntu

setup
--------

```
cd airvideo-server
docker pull ubuntu
docker build -t my-airvideo-server .
docker run -d -u avuser -e LANG=C.UTF-8 -p 45631:45631 -p 46631:46631 -v /path/to/my/movies:/Movies my-airvideo-server airvideo-server
```

note
-----

1. This doesnot work on OSX, because docker on OSX is running in virtual machine(via boot2docker), ports are binded inside virtual machine, and volumns are searched inside virtual machine too.
