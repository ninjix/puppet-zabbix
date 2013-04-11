class zabbix::agent (
  $zabbix_server,
  $enable          = true,
  $general_options = $zabbix::params::general_options,
  $agent_options   = $zabbix::params::agent_options) inherits zabbix::params {
 
 case $osfamily {
	RedHat  : {
    package { "zabbix20-agent": ensure => installed }

  $config_file = "${agent_options[config]}"
  $include_dir = "${general_options[config_dir]}/${agent_options[include_dir]}/"
  $script_dir = "${general_options[config_dir]}/${agent_options[script_dir]}/"

  file {
    $general_options[config_dir]:
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => Package["zabbix20-agent"];

    $include_dir:
      ensure  => directory,
      owner   => 'zabbix',
      group   => 'zabbix',
      mode    => '0700',
      require => Package["zabbix20-agent"];

    $script_dir:
      ensure  => directory,
      owner   => 'zabbix',
      group   => 'zabbix',
      mode    => '0700',
      require => Package["zabbix20-agent"];

    $config_file:
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("zabbix/zabbix_agentd_conf.erb"),
      require => Package["zabbix20-agent"];

    $agent_options[log_dir]:
      ensure  => directory,
      owner   => 'zabbix',
      group   => 'zabbix',
      mode    => '0755',
      require => Package["zabbix20-agent"];
  }

  service { "zabbix-agent":
    enable    => true,
    ensure    => running,
    hasstatus => true,
    require   => Package["zabbix20-agent"],
    subscribe => [File[$config_file], Package["zabbix20-agent"]];
  }
  }
  Debian  : {
  package { "zabbix-agent": ensure => installed }

  $config_file = "${general_options[config_dir]}/${agent_options[config]}"
  $include_dir = "${general_options[config_dir]}/${agent_options[include_dir]}/"
  $script_dir = "${general_options[config_dir]}/${agent_options[script_dir]}/"

  file {
    $general_options[config_dir]:
      ensure => directory,
      owner => 'root',
      group => 'root',
      mode => '0755',
      require => Package["zabbix-agent"];

    $include_dir:
      ensure => directory,
      owner => 'zabbix',
      group => 'zabbix',
      mode => '0700',
      require => Package["zabbix-agent"];

    $script_dir:
      ensure => directory,
      owner => 'zabbix',
      group => 'zabbix',
      mode => '0700',
      require => Package["zabbix-agent"];

    $config_file:
      owner => 'root',
      group => 'root',
      mode => '0644',
      content => template("zabbix/zabbix_agentd_conf.erb"),
      require => Package["zabbix-agent"];

    $agent_options[log_dir]:
      ensure => directory,
      owner => 'zabbix',
      group => 'zabbix',
      mode => '0755',
      require => Package["zabbix-agent"];
  }

  service { "zabbix-agent":
    enable => true,
    ensure => running,
    hasstatus => true,
    require => Package["zabbix-agent"],
    subscribe => [File[$config_file], Package["zabbix-agent"]];
  }

}
}
}

