#Development Environment Setup
This repository contains the files needed to bring up an operating system agnostic, complete self contained, local development environment for [NiceApp](https://github.com/oajara/pptyx_nice_app).

The environment consists of two  **[Docker](https://www.docker.com/)** containers inside a **[Vagrant](https://www.vagrantup.com/)** provisioned **[VirtualBox](https://www.virtualbox.org/)** virtual machine, allowing to deploy this whole environment in any operating system able to run **[VirtualBox](https://www.virtualbox.org/)**. The architecture is as follows:

![](https://technology.amis.nl/wp-content/uploads/2015/08/image70.png) 

This setup will allow the developer to modify the code in real time, while it is being served by the web server container. At the same time it speeds up the development environment setup and guarantees the same software version accross all developers.

_** Note: this was tested on a workstation running Ubuntu 16.04 Linux distribution._
***

###Required Software
If you already have all the needed software you can skip to the [next section](#headerSS).
The software required in your workstation is the following (tested versions between parentheses):

#### VirtualBox (5.0.18)
Go to [VirtualBox download page](https://www.virtualbox.org/wiki/Downloads)  and install VirtualBox version specific to your workstation's operating system.

#### Vagrant (1.8.5)
Go to [Vagrant download page](https://www.vagrantup.com/downloads.html) and install the Vagrant version specific to your workstation's operating system.

## <a name="headerSS"></a>Spining up the host virtual machine
####Clone the environments repository and submodules
`git clone --recursive git@github.com:oajara/pptyx_dev_env.git`

####Bring up the virtual machine and login into it
`cd pptyx_dev_env && vagrant up && vagrant ssh`

This makes use of the *Vagrantfile* file to build the virtual machine that will host the containers. If this is the first time you run the command you will probably need to wait for the Ubuntu virtual machine image and add-ons to download from Vagrant repositories. After a few minutes you should be inside a virtual machine's console.

This command will do a basic provisioning of the virtual machine, installing Docker software to be able to host the containers.

## Bringing the containers up
`cd /vagrant && docker-compose up -d`

This makes use of the *docker-compose.yml* file to pull the database container image, build the web server image on the fly and bring up the two containers. 

_Note: the first time the database container is up it will import the employees database dump and this may take a while** You can run **_docker logs vagrant_db_1_** to check if the import is finished._

####Managing the database
The environment's mysql database is available at your workstation's local 13306 port. So you can connect this way:

`mysql -h 127.0.0.1 --port 13306 -u root -p # password 'nice_secret'`

_Note: do not use 'localhost' as the database hostname because, depending on your operating system, it might try to connect using file sockets and it will fail to connect. Use '127.0.0.1'._

####Use the environment!
To hit the container's web server you must browse your workstation's local 10080 port: http://localhost:10080

The _pptyx_nice_app/_ directory inside the cloned repo in your workstation is mirrored in the document root of the web server container. This means the code changes in your local directory will be available for test in real time.
