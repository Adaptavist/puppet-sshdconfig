# SSHDConfig Module

## Overview

The **SSHDConfig** module configures sshd on all managed hosts by distributing a configuration file to each of them.

## Configuration

Class accepts configuration template location that represents path to erb file to be used as template for /etc/ssh/sshd_config 

In case not provided it defaults to "${module_name}/sshd_config.erb"

The shared configuration file can be found at `templates/sshd_config.erb`.

## Dependencies

This module has no dependencies on other puppet modules.
