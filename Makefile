
LOCAL_TARGET=heatmap
WEB_TAG=latest
WEB_TARGET="emetabohub/heatmap:${WEB_TAG}"

INIT_PLANEMO_CMD=cd "\$PLANEMO_VENV" ; . ./bin/activate

docker:
	@echo "Building ${LOCAL_TARGET} image..."
	@docker build -t ${LOCAL_TARGET} . # 1> /dev/null
	@echo "Image created, taging image: ${WEB_TARGET}"
	@docker tag ${LOCAL_TARGET}:latest ${WEB_TARGET}

test:
	@~/R/bin/Rscript ./test.R

push_hub:docker docker_login
	docker push ${WEB_TARGET}

docker_login:
	cat .password | docker login --username=$$(cat .username) --password-stdin

remove_login: docker_logout
	rm ~/.docker/config.json

docker_logout:
	docker logout