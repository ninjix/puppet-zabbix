define zabbix::addscript (
  $ensure          = present,
  $general_options = $zabbix::params::general_options,
  $agent_options   = $zabbix::params::agent_options) {
  include zabbix::params

  $script_dir = "${general_options[config_dir]}/${agent_options[script_dir]}/"

  file { "${script_dir}/${name}.conf":
    ensure  => $ensure,
    group   => 'zabbix',
    owner   => 'zabbix',
    mode    => '0700',
    source  => "puppet:///zabbix/${name}",
    require => File["${script_dir}"]
  }
}
