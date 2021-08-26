#!/bin/bash

export OS=darwin
export OS_ALT=mac

echo "=== Download the cli bundle at https://customerconnect.vmware.com/en/downloads/details?downloadGroup=TKG-131&productId=988&rPId=65946#product_downloads"

tar -xvf "tanzu-cli-bundle-v1.3.1-${OS}-amd64.tar"

echo "Navigate to the tanzu/cli"
pushd cli || exit 
{
    pwd
    
    echo "Make the CLI available to the system"
    sudo install core/v1.3.1/tanzu-core-${OS}_amd64 /usr/local/bin/tanzu

    tanzu version

    echo "Install the Tanzu CLI Plugins"

    echo "cleaning previous installations"
    tanzu plugin clean

    popd || exit
}

echo "Install all the plugins for this release"
tanzu plugin install --local cli all

echo "Check plugin installation status"
tanzu plugin list

tanzu --help

echo "Install kubectl"

echo "unpack bynary"
ls
test -f kubectl-${OS_ALT}-v1.20.5-vmware.1.gz || echo "file not found. move kubectl .gz to tanzu folder" 
gunzip kubectl-${OS_ALT}-v1.20.5-vmware.1.gz
chmod +x ./bin/kubectl*
sudo mv ./bin/kubectl* /usr/local/bin/
rm -rf ./bin


chmod +x ./bin/kubectl*
sudo mv ./bin/kubectl* /usr/local/bin/
rm -rf ./bin

echo "Navigate to the kubectl binary that you unpacked"
sudo install kubectl-${OS}-v1.20.5-vmware.1 /usr/local/bin/kubectl

ls

pushd cli || exit
{
    echo ytt
    gunzip ytt-${OS}-amd64-v0.31.0+vmware.1.gz
    chmod ugo+x ytt-${OS}-amd64-v0.31.0+vmware.1
    sudo mv ytt-${OS}-amd64-v0.31.0+vmware.1 /usr/local/bin/ytt
    
    echo kapp
    gunzip kapp-${OS}-amd64-v0.36.0+vmware.1.gz
    chmod ugo+x kapp-${OS}-amd64-v0.36.0+vmware.1
    sudo mv kapp-${OS}-amd64-v0.36.0+vmware.1 /usr/local/bin/kapp
    
    echo kbld
    gunzip kbld-${OS}-amd64-v0.28.0+vmware.1.gz
    chmod ugo+x kbld-${OS}-amd64-v0.28.0+vmware.1
    sudo mv  kbld-${OS}-amd64-v0.28.0+vmware.1 /usr/local/bin/kbld

    echo imgpkg
    gunzip imgpkg-${OS}-amd64-v0.5.0+vmware.1.gz
    chmod ugo+x imgpkg-${OS}-amd64-v0.5.0+vmware.1
    sudo mv imgpkg-${OS}-amd64-v0.5.0+vmware.1 /usr/local/bin/imgpkg

    popd || exit
}

rm -rf cli

### vsphere specific

# echo "install kubectl vsphere plugin"
# sudo apt install unzip

# unzip vsphere-plugin.zip

# kubectl vsphere

# echo "install vcenter certs"
# wget https://pacific-vcsa.haas-490.pez.vmware.com/certs/download.zip --no-check-certificate
# unzip download.zip
# sudo cp ./certs/lin/*.0 /usr/local/share/ca-certificates/
# sudo cp ./certs/lin/*.0 /etc/ssl/certs/

# rm -rf ./certs
# rm download.zip*


echo ==== DONE ====