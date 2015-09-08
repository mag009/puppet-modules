# == Class: aerospike
#
# This class installs and configures aerospike.
#
# === Parameters
#
# [*install_dir*]
#   Install directory of aerospike.
#   Default is '/opt'
#
class aerospike (
  $config_dir                           = '/etc/aerospike',
  $user                                 = 'root',
  $group                                = 'root',
  $paxos_single_replica_limit           = '1',
  $paxos_recovery_policy                = 'manual',
  $auto_dun                             = 'false',
  $auto_undun                           = 'false',
  $pidfile                              = '/var/run/aerospike/asd.pid',
  $service_threads                      = '4',
  $fabric_workers                       = '12',
  $transaction_queues                   = '4',
  $transaction_threads_per_queue        = '3',
  $transaction_pending_limit            = '2',
  $nsup_startup_evict                   = 'true',
  $nsup_period                          = '120',
  $storage_benchmarks                   = 'false',
  $microbenchmarks                      = 'false',
  $respond_client_on_master_completion  = 'true',
  $proto_fd_max                         = '50000',
  $hist_track_thresholds                = '1,4,8,16,32,64,128,256,512,1024,2048,4096,8192',
  $logfile                              = '/var/log/aerospike/aerospike.log',
  $address                              = 'any',
  $port                                 = '3000',
  $access_address                       = "${::ipaddress}",
  $mode                                 = 'mesh',
  $heartbeat_address                    = "${::ipaddress}",
  $heartbeat_port                       = '3002',
  $mesh_seed_address_port               = [ ],
  $interval                             = '150',
  $timeout                              = '10',
  $fabric_port                          = '3001',
  $info_address                         = 'any',
  $info_port                            = '3003',
  $namespace                            = [ ],
) {

  # The anchor resources allow the end user to establish relationships
  # to the "main" class and preserve the relationship to the
  # implementation classes through a transitive relationship to
  # the composite class.
  # https://projects.puppetlabs.com/projects/puppet/wiki/Anchor_Pattern
  anchor { 'aerospike::begin': }->
  class { 'aerospike::install': }->
  class { 'aerospike::config': }->
  anchor { 'aerospike::end': }
}
