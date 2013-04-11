class zabbix::agent (
  $zabbix_server,
  $enable          = true,
  $general_options = $zabbix::params::general_options,
  $agent_options   = $zabbix::params::agent_options) inherits zabbix::params {
  package { "zabbix-agent20": ensure => installed }

  $config_file = "${general_options[config_dir]}/${agent_options[config]}"
  $include_dir = "${general_options[config_dir]}/${agent_options[include_dir]}/"
  $script_dir = "${general_options[config_dir]}/${agent_options[script_dir]}/"

  file {
    $general_options[config_dir]:
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => Package["zabbix-agent20"];

    $include_dir:
      ensure  => directory,
      owner   => 'zabbix',
      group   => 'zabbix',
      mode    => '0700',
      require => Package["zabbix-agent20"];

    $script_dir:
      ensure  => directory,
      owner   => 'zabbix',
      group   => 'zabbix',
      mode    => '0700',
      require => Package["zabbix-agent20"];

    $config_file:
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("zabbix/zabbix_agentd_conf.erb"),
      require => Package["zabbix-agent20"];

    $agent_options[log_dir]:
      ensure  => directory,
      owner   => 'zabbix',
      group   => 'zabbix',
      mode    => '0755',
      require => Package["zabbix-agent20"];
  }

  service { "zabbix-agent":
    enable    => true,
    ensure    => running,
    hasstatus => true,
    require   => Package["zabbix-agent20"],
    subscribe => [File[$config_file], Package["zabbix-agent20"]];
  }

}
