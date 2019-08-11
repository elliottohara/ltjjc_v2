#!/usr/bin/env bash
export TF_DIR="$(pwd)/terraform"
export AWS_PROFILE=ltjjc
export SITE_DIR="$(pwd)/src"
cd_tf(){
    cd "${TF_DIR}"
}
init() {
    terraform init

}
plan(){
    terraform plan

}
apply(){
    terraform apply
}
push(){
    cd_tf
    DOMAIN=$(terraform output -json | jq -r .website.value)
    aws s3 sync --delete "${SITE_DIR}" "s3://${DOMAIN}"
}
deploy(){
    cd_tf
    plan
    apply
    push
}

dev(){
    docker-compose up
}
"${@:-}"