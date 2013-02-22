# puppet-zabbix

## Overview

This module manages the Zabbix agents. Some of trydock's puppet-zabbix module is used. I liked how that zabbix module handles user parameters.  

Please see: https://github.com/treydock/puppet-zabbix.git

## Features

* Installs Zabbix agent
* Allows additional userparameter 

## Usage

This module is still in work. I'm going to expand it to installing servers and proxies.

### Basic

Specify the class with a zabbix server address or DNS.

```
  class { 'zabbix::agent':
    zabbix_server => '10.1.30.30'
  }
```

### Adding a userparameter templates

```
  zabbix::userparameter { ['apache', 'memcache']: }
```

### Adding agent scripts

Some userparameter calls require local helper scripts.

```
    zabbix::addscript { 'zapache': }
```

