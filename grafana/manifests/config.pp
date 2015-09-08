# == Class: grafana::config
#
# This configures the config.js of grafana.
# SHOULD NOT be called directly.
#
# === Parameters
#
# None.
#
class grafana::config {
  file {
    "${::grafana::config_dir}/grafana.ini":
      ensure  => file,
      content => template('grafana/etc/grafana/grafana.ini')
  }

  package { 'grafana':
    ensure => $grafana::version,
  }
  

  service { 'grafana-server':
    ensure     => running,
    provider   => systemd,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File["${::grafana::config_dir}/grafana.ini"],
    require    => [ File["${::grafana::config_dir}/grafana.ini"], Package['grafana'] ] 
  }
}
