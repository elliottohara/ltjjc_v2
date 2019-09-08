#!/usr/bin/env bash
export TF_DIR="$(pwd)/terraform"
export SITE_DIR="$(pwd)/src"
aws_profile="ltjjc"
aws_credentials="${HOME}/.aws"
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
    domain=$(tf output -json | jq -r .website.value)
    aws s3 sync --profile "${aws_profile}" --delete "${SITE_DIR}" "s3://${domain}"
    #docker run -v "${aws_credentials}:/home/.aws":ro -v "${SITE_DIR}:/dist":ro -e "HOME=/home" "${terraform_image}" aws s3 sync --profile "${aws_profile}" --dry-run  /dist "s3:${domain}"

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