# Class: glusterfs::firewall
#
# GlusterFS Firewall
#
class glusterfs::firewall (
) {

  define insert_rule ( $host = $title){

    unless $::hostname in $title { 
      firewall { "111 glusterfs-server accept tcp from ${host}":
        proto  => 'tcp',
        dport  => ['24007'],
        source => $host,
        action => accept,
      }
    }
  }

  if !empty($sugarcrmstack::glusterfs_peers) {
    insert_rule { $sugarcrmstack::glusterfs_peers: }
  }
  else {
    warning { "no glusterfs peers defined..": }
  }
}

