#!/usr/bin/env bash
export TF_DIR="$(pwd)/terraform"
export SITE_DIR="$(pwd)/src"
terraform_image="hashicorp/terraform:light"
openssl_image="pgarrett/openssl-alpine"

tf(){
    # Runs terraform in docker container
    docker run -i -t -v "${TF_DIR}:/tf"  -w /tf "${terraform_image}" "${@}"
}
init() {
    tf
}
cert(){
    docker run --rm -v "$(pwd)/Docker/certs:/etc/ssl/certs" "${openssl_image}"
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
    cert
    docker-compose up
}
"${@:-}"