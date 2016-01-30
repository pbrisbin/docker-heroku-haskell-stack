IMAGE_NAME ?= pbrisbin/heroku-haskell-stack

image:
	docker build --tag $(IMAGE_NAME) .
	docker tag --force $(IMAGE_NAME) $(IMAGE_NAME):1.0.2

.PHONY: image
