function etcdctrl_execute() {
    bin/etcdctl --endpoints "http://10.150.11.24:2379" $*
}
function mermber_list()
{
    etcdctrl_execute member list
}
function cluster_health() {
    etcdctrl_execute cluster-health
}
function get_value() {
    etcdctrl_execute get $*
}
function list_value() {
    etcdctrl_execute ls $*
}
mermber_list
cluster_health
get_value "/Input/LX/Sugg/active_min_showtime_interval"
list_value "/Input"
