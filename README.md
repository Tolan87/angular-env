### **Supported Tags** ###
* [ `8.11.1` `8.11` `8` `latest` (*Dockerfile*) ](https://github.com/Tolan87/angular-env/tree/master/8/Dockerfile)
* [ `9.11.1` `9.11` `9` (*Dockerfile*) ](https://github.com/Tolan87/angular-env/tree/master/9/Dockerfile)
* [ `10.0.0` `10.0` `10` (*Dockerfile*) ](https://github.com/Tolan87/angular-env/tree/master/10/Dockerfile)

*Tags based on installed node version*

#### **Quick reference** ####
* **Where to get help**  
	[Docker Community Forums](https://forums.docker.com/), [Docker Community Slack](https://blog.docker.com/2016/11/introducing-docker-community-directory-docker-community-slack/), or [Stack Overflow](https://stackoverflow.com/search?tab=newest&q=docker)

* **Where to file issues**
<https://github.com/Tolan87/angular-env/issues>

* **Maintained by** 
Toni Langbein

* **Supported architectures**
`amd64` `i386` `arm32v6 (untested)` `arm32v7 (untested)` `arm64v8 (untested)`

* **Source of this description**
[Repository](https://github.com/Tolan87/angular-env)

* **Supported Docker versions**:  
[Latest release](https://github.com/docker/docker-ce/releases/latest)

#### **How to use** ####
```
$ docker run --rm -v x:/project/dist/:/var/www/localhost/htdocs:ro -d tolanhd/angular-env
```
A cleaner solution than bind a mount is to create a `Dockerfile` in your angular project 
root folder to create a new image that includes the content, like the example below.

** Dockerfile Example **
>FROM tolanhd/angular-env
COPY /dist/* /var/www/localhost/htdocs/
CMD ["nginx"]

Run `docker build -t mytag .` in the directory where the `Dockerfile` is located to create a 
new image with the name *`mytag`* in this example.

When your build is complete, start a new container.
`$ docker run --rm -d mytag`

##### ** Exposing port ** #####
Expose the port **80** from container to port **8080** on the host
`$ docker run --rm -d -p 8080:80 mytag`
Now you can navigate to `http://localhost:8080` or `http://host-ip:8080` in your favorite browser.
