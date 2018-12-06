function get_server_ip() {
    ifconfig  |grep "inet 10" | tail -n1 | awk '{print $2}'
}
function get_init_cluster_conf() {
    file=$1
    awk '{
      curr_conf=sprintf("%s=http://%s:2380", $2, $1);
      if (conf) {
        conf=sprintf("%s,%s", conf, curr_conf);
      }
      else {
        conf=curr_conf;
      }
    }END{
        print conf
    }' $file
} 
function get_server_name() {
    local file=$1
    local ip=$2
    grep $ip $file | awk '{print $2}'
}
function generate_curr_conf() {
    local config=$1
    local key=$2
    local value=$3
    sed -i 's|'"${key}"'|'"${value}"'|g' $config
}
function get_conf_name() {
    local seed_conf=$1
    local ip=$2
    echo $(dirname $seed_conf)/$ip.conf
}
server_dict=$1
seed_conf=$2
ip=$(get_server_ip)
server_name=$(get_server_name $server_dict $ip)
echo $ip, $server_name
cluster_list=$(get_init_cluster_conf $server_dict)
new_conf_name=$(get_conf_name $seed_conf $ip)
cp $seed_conf $new_conf_name
generate_curr_conf $new_conf_name "node_name" "$server_name"
generate_curr_conf $new_conf_name "local_ip" "$ip"
generate_curr_conf $new_conf_name "cluster_list" "$cluster_list"
