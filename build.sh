#!/usr/bin/env bash
export TF_DIR="$(pwd)/terraform"
export SITE_DIR="$(pwd)/src"
terraform_image="hashicorp/terraform:light"

_run_terraform(){
    # Runs terraform in docker container
    docker run -i -t -v "${TF_DIR}:/tf" -w /tf "${terraform_image}" "${@}"
}
init() {
    _run_terraform init

}
plan(){
   _run_terraform plan

}
apply(){
    _run_terraform apply
}
push(){
    DOMAIN=$(terraform output -json | jq -r .website.value)
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