# == Class: zabbix::params
#
# This is a container class holding default parameters for for zabbix class.
#  currently, only the Ubuntu family is supported, but this can be easily
#  extended by changing package names and configuration file paths.
#
class zabbix::params {
  case $osfamily {
    Debian  : {
      $general_options = {
        'config_dir'   => '/etc/zabbix',
        'log_filesize' => '0',
        'user'         => 'zabbix',
        'group'        => 'zabbix'
      }
      $agent_options = {
        'config'      => 'zabbix_agentd.conf',
        'pid_dir'     => '/var/run/zabbix',
        'pid_file'    => 'zabbix_agentd.pid',
        'log_dir'     => '/var/log/zabbix-agent',
        'log_file'    => 'zabbix_agentd.log',
        'include_dir' => 'zabbix_agentd.conf.d',
        'script_dir'  => 'scripts',
        'remote_cmds' => '1',
      }
    }
    default : {
      fail("The $::osfamily operating system is not supported with the zabbix module")
    }
  }
}
