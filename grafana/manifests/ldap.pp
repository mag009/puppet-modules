# == Class: grafana::ldap
#
# This configures the config.js of grafana.
# SHOULD NOT be called directly.
#
# === Parameters
#
# None.
#
class grafana::ldap (
    $host  = "",
    $port  = "636",
    $ssl   = 'true',
    $ssl_verify = 'true',
    $bind_dn = "",
    $bind_pw = "",
    $filter = "(userPrincipalName=%s)",
    $base_dns = "dc=your,dc=org",
    $group_mappings = [],

) {

  if $grafana::auth_ldap == 'true' {
      file {
        "${::grafana::config_dir}/ldap.toml":
          ensure  => file,
          content => template('grafana/etc/grafana/ldap.toml')
      }
  }
}
