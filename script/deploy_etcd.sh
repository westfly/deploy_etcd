target=/search/odin/online_env/etcd
function get_binary() {
    rm -rf $target
    mkdir $target
    rsync 10.139.48.96::root/search/odin/aresyang/coding/discover/* -aP $target
}
function generate_config() {
    cd $target
    sh script/etcd_conf_generate.sh data/seed_server.dat etc/etcd/etcd.conf
    sh script/stop.sh
    sh script/start.sh
}
set -x
get_binary
generate_config
