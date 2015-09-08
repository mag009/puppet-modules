# == Class: aerospike::config
#
# This configures the aerospike.conf
# SHOULD NOT be called directly.
#
# === Parameters
#
# None.
#
class aerospike::config {
  file {
    "${::aerospike::config_dir}/aerospike.conf":
      ensure  => file,
      content => template('aerospike/etc/aerospike/aerospike.conf')
  }

  service { 'aerospike':
    ensure     => running,
    #provider   => systemd, not yet 
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File["${::aerospike::config_dir}/aerospike.conf"],
    require    => File["${::aerospike::config_dir}/aerospike.conf"],
  }
}
