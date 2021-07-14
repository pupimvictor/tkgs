#!/bin/bash +x

# set -o errexit
# set -o errtrace
# set -o pipefail

## download URLS
PIVNET_CLI="https://github.com/pivotal-cf/pivnet-cli/releases/download/v3.0.1/pivnet-linux-amd64-3.0.1"


function pivnet_login()
{
    if test -z "$PIVNET_TOKEN" 
    then
        echo "please set PIVNET_TOKEN"
        exit
    fi
    pivnet login --api-token "$PIVNET_TOKEN"
}

function download_carvel_tools()
{
    echo kapp
    pivnet download-product-files --product-slug='kapp' --release-version='0.36.0' --product-file-id=903765
    chmod +x kapp*
    sudo mv kapp* /usr/local/bin/kapp

    echo imgpkg
    pivnet download-product-files --product-slug='imgpkg' --release-version='0.12.0' --product-file-id=980284
    chmod +x imgpkg*
    sudo mv imgpkg* /usr/local/bin/imgpkg
    
    echo kbld
    pivnet download-product-files --product-slug='kbld' --release-version='0.30.0' --product-file-id=949949
    chmod +x kbld*
    sudo mv kbld* /usr/local/bin/kbld

    echo ytt
    pivnet download-product-files --product-slug='ytt' --release-version='0.34.0' --product-file-id=961334
    chmod +x ytt*
    sudo mv ytt* /usr/local/bin/ytt


}

function download_kp()
{
    echo kp
    pivnet download-product-files --product-slug='build-service' --release-version='1.2.1' --product-file-id=970671
    chmod +x kp*
    sudo mv kp* /usr/local/bin/kp
}

function download_tbs_descriptor()
{
    echo descriptor
    pivnet download-product-files --product-slug='tbs-dependencies' --release-version='100.0.124' --product-file-id=995111
}


