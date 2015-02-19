airvideo-server
===============

docker file to setup airvideo server on ubuntu

setup
--------

```
docker run -d --restart=always --name airvideo -h airvideo -p 45631:45631 -p 46631:46631 -v /net/je-nas/c/media:/Movies justintime/airvideo
```

note
-----

1. This doesnot work on OSX, because docker on OSX is running in virtual machine(via boot2docker), ports are binded inside virtual machine, and volumns are searched inside virtual machine too.
