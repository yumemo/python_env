# VM init for CentOS 7
## local machine

```
$ scp ~/.ssh/id_rsa ${target_machine}:~/.ssh/
```

## VM
### setting swap
```
$ sudo dd if=/dev/zero of=/swapfile bs=1M count=1024
$ sudo chmod 600 /swapfile
$ sudo mkswap /swapfile
$ sudo swapon /swapfile
$ sudo sed -i '$ a /swapfile                                 swap                    swap    defaults        0 0' /etc/fstab
```
### install packages and setting
```
$ sudo yum -y update
$ sudo yum -y upgrade
$ sudo yum -y install git
$ sudo yum -y install docker
$ sudo yum -y install docker-compose
$ sudo groupadd docker
$ sudo gpasswd -a ${USER} docker
$ sudo systemctl restart docker
```

### work on repo
```
$ git clone git@github.com:yumemo/python_env.git
$ cd yumemo_env/init
$ bash init.sh
```
*require modifying your name and email