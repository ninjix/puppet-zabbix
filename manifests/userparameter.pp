define zabbix::userparameter (
  $ensure          = present,
  $general_options = $zabbix::params::general_options,
  $agent_options   = $zabbix::params::agent_options) {
  include zabbix::params

  $include_dir = "${general_options[config_dir]}/${agent_options[include_dir]}/"
  $script_dir = "${general_options[config_dir]}/${agent_options[script_dir]}/"

  file { "${include_dir}/${name}.conf":
    ensure  => $ensure,
    group   => 'zabbix',
    owner   => 'zabbix',
    mode    => '600',
    content => template("zabbix/userparameter_${name}.erb"),
    require => File["${include_dir}"],
    notify  => Service['zabbix-agent'],
  }
}
