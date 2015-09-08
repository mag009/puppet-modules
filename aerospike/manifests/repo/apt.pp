# = Class: aerospike::repo::apt
#
# Adds the aerospike repo to Apt
#
# == Parameters
#
class aerospike::repo::apt {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if defined(apt::source) {

    $ensure = $aerospike::install_repo ? {
      true    => 'present',
      default => 'absent'
    }

    if $aerospike::repo_source {
      $url = $aerospike::repo_source
    } else {
      $url = 'http://repos.aerospikeapp.org/apt'
    }

    apt::source { 'aerospike':
      ensure   => $ensure,
      location => $url,
      release  => 'aerospike',
      repos    => $aerospike::repo,
      include  => {
        'src' => false,
      },
      key      => {
        'id'     => $aerospike::repo_key_id,
        'source' => $aerospike::repo_key_source,
      },
      before   => Package['aerospike-server-community'],
    }

  } else {
    fail('This class requires puppetlabs-apt module')
  }

}
