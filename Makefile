infrastructure:
	./build.sh deploy_infra

push:
	./build.sh push

deploy: infrastructure push

local_dev:
	./build.sh dev