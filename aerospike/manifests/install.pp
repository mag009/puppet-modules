# == Class: aerospike::install
#
# This class downloads and installs aerospike.
# SHOULD NOT be called directly.
#
# === Parameters
#
# None.
#
class aerospike::install {

   case $::osfamily {
 
     'Debian': {
       if $aerospike::install_repo {
         class { 'aerospike::repo::apt': }
         include apt
         $repo_require = Apt::Source['aerospike']
       } else {
         $repo_require = undef
       }
     }
 
     default: { fail("${::osfamily} not supported yet") }
 
   }

   package { [ 'aerospike-server-community', 'python-argparse' ]: ensure => present }

}
