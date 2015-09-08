# == Class: grafana
#
# This class installs and configures grafana.
#
# === Parameters
#
# [*install_dir*]
#   Install directory of grafana.
#   Default is '/opt'
#
class grafana (
  $config_dir           = '/etc/grafana',
  $protocol              = 'http',
  $http_address          = '',
  $port                  = 3000,
  $domain                = 'localhost',
  $router_logging        = 'false',
  $static_root_path      = '/usr/share/grafana/public',
  $gzip                  = 'false',
  $cert_file             = '',
  $cert_key              = '',
  $version               = 'latest',
  $db_type               = 'mysql',
  $db_host               = '',
  $db_name               = 'grafana',
  $db_user               = '',
  $db_password           = '',
  $auth_ldap             = 'false',  
  $auth_proxy            = 'true',
  $allow_sign_up         = 'true',
  $allow_user_create_org = 'true',
  $auto_assign_org       = 'true',
  $anonymous_access      = 'false',
  $default_org           = '',
  $default_role          = 'Viewer',
  $sess_provider         = 'file',
  $sess_provider_config  = '/opt/grafana/data/session',
) {

  # The anchor resources allow the end user to establish relationships
  # to the "main" class and preserve the relationship to the
  # implementation classes through a transitive relationship to
  # the composite class.
  # https://projects.puppetlabs.com/projects/puppet/wiki/Anchor_Pattern
  anchor { 'grafana::begin': }->
  class { 'grafana::ldap': }->
  class { 'grafana::config': }->
  anchor { 'grafana::end': }
}
