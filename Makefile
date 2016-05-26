NAME=go-deploy-boilerplate
USER=ubuntu
IP=127.0.0.1
HOST=$(USER)@$(IP)
BINDIR=/home/$(USER)/bin
RUNDIR=/home/$(USER)/$(NAME)
BIN=./$(NAME)_linux_amd64

deploy: $(BIN)
	ssh $(HOST) "mkdir -p $(BINDIR) && mkdir -p $(RUNDIR)"
	ssh -t $(HOST) "sudo stop $(NAME) || true"
	scp $(BIN) $(HOST):$(BINDIR)/$(NAME)
	scp ./$(NAME).conf $(HOST):$(RUNDIR)/$(NAME).conf
	ssh -t $(HOST) "sudo cp $(RUNDIR)/$(NAME).conf /etc/init/$(NAME).conf && sudo start $(NAME)"
	
$(BIN): main.go
	gox -osarch="linux/amd64"
	
compile: main.go
	go build	
	
test: compile
	go test