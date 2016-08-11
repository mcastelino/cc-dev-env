# cc-dev-env

Quickstart container for developing and testing the [cc-oci-runtime] (https://github.com/01org/cc-oci-runtime). The source code for the runtime is automatically downloaded and built as part of the creation of this container.

Running this container
------------------------------
```
sudo docker run -it -e HTTP_PROXY="xxx" -e HTTPS_PROXY="yyy" --privileged mcastelino/cc-dev-env
```

The container needs to run as privileged in order to launch docker clear containers from within the clearlinux docker container. 
For just building the container runtime --privileged is not required

To launch docker with cc-oci-runtime as the runtime 
--------------------------------------------------------------------
Within the container

1. Launch the docker daemon
```
./run_dockerd
```
2. Launch a clear container
```
docker run -it debian
```

This will launch a clear container within the docker clearlinux container

# Building this container from Dockerfile

```
git clone https://github.com/mcastelino/cc-dev-env
cd cc-dev-env
sudo docker build --build-arg HTTP_PROXY="your proxy if needed" --build-arg HTTPS_PROXY="your proxy if needed" -t mcastelino/cc-dev-env .
```


