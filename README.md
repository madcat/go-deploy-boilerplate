## go-deploy-boilerplate
one way to deploy a service written in golang to a linux server.

server doesn't need to have golang development environment nor git.

doesn't need to login to server each time the program is updated.

### requirements:

cross compile:

  go get github.com/mitchellh/gox


### process

* cross compile go program on local machine, to target architecture (assuming 64bit ubuntu here)
* copy built binary to server
* stop the serivce if alreay started
* copy upstart config file to /etc/init/ on server
* start the service