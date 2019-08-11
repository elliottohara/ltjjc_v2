#!/usr/bin/env bash
export TF_DIR="$(pwd)/terraform"
export SITE_DIR="$(pwd)/src"
export AWS_PROFILE=ltjjc
terraform_image="hashicorp/terraform:light"

tf(){
    # Runs terraform in docker container
    docker run -i -t -v "${TF_DIR}:/tf" -w /tf "${terraform_image}" "${@}"
}
init() {
    tf init

}
plan(){
   tf plan

}
apply(){
    tf apply
}
push(){
    DOMAIN=$(tf output -json | jq -r .website.value)
    aws s3 sync --delete "${SITE_DIR}" "s3://${DOMAIN}"
}
deploy_infra(){
    plan
    apply
}

dev(){
    docker-compose up
}
"${@:-}"