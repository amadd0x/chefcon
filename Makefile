IMAGE=amadd0x/chefcon
VERSION=latest

build:
	docker buildx build --no-cache --progress=plain --platform=linux/amd64 -t $(IMAGE) .

login:
	bash -c "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(AWS_ACCOUNT).dkr.ecr.us-east-1.amazonaws.com"

push: login
	docker tag $(IMAGE):$(VERSION) $(AWS_ACCOUNT).dkr.ecr.us-east-1.amazonaws.com/$(IMAGE):$(VERSION)
	docker push $(AWS_ACCOUNT).dkr.ecr.us-east-1.amazonaws.com/$(IMAGE):$(VERSION)

run:
	docker run -it --rm $(IMAGE):$(VERSION)
