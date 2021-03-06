# $1 is prefix of the machines to be deleted

if [ ! -z $1 ]; then

    echo "Machine with prefixes ${1} will be cleaned"

    echo "Cleaning VirtuslBox machines"
    for i in $(VBoxManage list vms | grep ${1} | grep -o '"[^\"]*"' | tr -d '"'); do
        echo $i
        VBoxManage controlvm $i poweroff
        VBoxManage unregistervm $i -delete
    done

    echo "Cleaning machines with virsh"
    for i in $(virsh list --name | grep ${1}); do
      virsh shutdown $i
      virsh destroy $i
      virsh undefine $i
    done

    echo "Cleaning docker machines"
    for i in $(docker ps --all -f "name=${1}" --format "{{.Names}}"); do
      docker rm -v $i
    done


else
    echo "You need to define machine prefix as first argument!"
fi
