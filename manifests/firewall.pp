# Class: glusterfs::firewall
#
# GlusterFS Firewall
#
class glusterfs::firewall (
) {

  define insert_rule ( $host = $title){

    unless $::hostname in $title { 
      firewall { "120 glusterfs-server accept tcp from ${host}":
        proto  => 'tcp',
        dport  => ['2049', '24007', '49152 - 49155',],
        source => $host,
        action => accept,
      }

      firewall { "111 glusterfs-server mapper accept tcp from ${host}":
        dport  => ['111',],
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

