deploy=$(pwd)
function get_server_ip() {
    ifconfig  |grep "inet 10" | tail -n1 | awk '{print $2}'
}
ip=$(get_server_ip)
config_name=etc/etcd/$ip.conf
echo $ip
nohup $deploy/bin/etcd --config-file=$config_name &
