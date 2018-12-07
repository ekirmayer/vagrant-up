execute "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"
#add the correct repo
execute'Execute a shell' do
  command 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF'
end
execute "apt -y remove docker docker-engine docker.io"
execute "apt -y update"
execute "apt -y upgrade"

#execute "apt install -y docker.io"
execute "apt install -y apt-transport-https ca-certificates curl software-properties-common"
execute "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"
execute " add-apt-repository \\
        \"deb [arch=amd64] https://download.docker.com/linux/ubuntu \\
   $(lsb_release -cs) \\
   stable\""
execute "apt -y update"
execute "apt -y install docker-ce=17.06.2~ce-0~ubuntu"
execute "usermod -aG docker vagrant"
execute "systemctl enable docker"


execute "apt install -y kubelet kubeadm kubectl"

execute "kubeadm init --pod-network-cidr=10.244.0.0/16"

# copy the join token and keep it
execute "mkdir -p /home/vagrant/.kube"
execute "cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config"
execute "chown vagrant:vagrant /home/vagrant/.kube/config"

#Start CNI
#copy the join token and keep it
execute "mkdir -p $HOME/.kube"
execute "cp -i /etc/kubernetes/admin.conf $HOME/.kube/config"
execute "chown $(id -u):$(id -g) $HOME/.kube/config"
#execute "kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml"
execute "kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/canal/rbac.yaml"
execute "kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/canal/canal.yaml"
