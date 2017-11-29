# ephemeris

master branch: [![Build Status](https://secure.travis-ci.org/millerjl1701/millerjl1701-ephemeris.png?branch=master)](http://travis-ci.org/millerjl1701/millerjl1701-ephemeris)

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with ephemeris](#setup)
    * [What ephemeris affects](#what-ephemeris-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ephemeris](#beginning-with-ephemeris)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Module Description

This module manages the installation and configuration of ephemeris.

Ephemeris is a python library and set of scripts used for mananging Galaxy plugins- tools, index data, and workflows.

* [Ephemeris GitHub Code Repository](https://github.com/galaxyproject/ephemeris) 
* [Ephemeris Documentation](https://ephemeris.readthedocs.io/en/latest/readme.html)

Galaxy is an open, web-based platform for accessible, reproducible, and transparent computational biomedical research.

* [Galaxy Project Web Site](https://galaxyproject.org)
* [Galaxy Documentation](https://galaxyproject.org/docs/)
* [Galaxy GitHub Code Repository](https://github.com/galaxyproject/galaxy)

The ephemeris puppet module defaults are such that it will install a virtualenv in the location /root/ephemeris for the root user; however, this is not the anticipated use case for the module. It is more likely to be included on a workstation for a unprivileged user or on a Galaxy server as the galaxy user. Please see the Usage section below for examples.

## Setup

### What ephemeris affects

* Creation of a python virtual environment
* Installation of necessary pip packages into the python virtual environment.

### Setup Requirements

This module sets up python 2.7 for use in a virtualenv leveraging the stankevich/python puppet module. As such, this module will not work with a different module either named python in your modules directory or with an other named module whose purpose is to manage python.

The stahnma/epel puppet module is a dependency of the stankevich/python puppet module and should be included in your puppet environment if you want the stankevich/python puppet module to manage epel as well. See the examples below for how to disable the stankevich/python puppet module from managing epel for installing pip.

### Beginning with ephemeris

`include ephemeris` will install and configure ephemeris into a virtualenv for root in the directory /root/ephemeris. This is likely not the typical use case for this module as it is more likely to use ephemeris on a workstation as an unprivileged user or on a Galaxy server as the galaxy user.

## Usage

All parameters to the main class can be passed via puppet code or hiera.

Some examples are presented below showing the purpose of some of the parameters of classes of the module.

### Install ephemeris into a python virtual environment for use by the Galaxy user account

```puppet
class { 'ephemeris':
  virtualenv_dir   => '/opt/galaxy/ephemeris',
  virtualenv_group => 'galaxy',
  virtualenv_owner => 'galaxy',
  virtualenv_mode  => '0775',
}
```

This example assumes that the galaxy user/group already exists on the system via another puppet module, a node manifest or hiera data, or some other means.

### Install ephemeris into a python virtual environment for use by the Galaxy user account while not using EPEL for the pip package

```puppet
class { 'ephemeris':
  manage_python_use_epel => false,
  virtualenv_dir         => '/opt/galaxy/ephemeris',
  virtualenv_group       => 'galaxy',
  virtualenv_owner       => 'galaxy',
  virtualenv_mode        => '0775',
}
```

In order for the stankevich/python puppet module to install pip on RedHat or CentOS systems, it by default also manages the installation of epel. If epel is managed via some other means or if the pip package is availble in a different repository, this behavior will need to be disabled by passing the manage_python_use_epel parameter as falses.

This example assumes that the galaxy user/group already exists on the system via another puppet module, a node manifest or hiera data, or some other means.

## Reference

Generated puppet strings documentation with examples is available from [https://millerjl1701.github.io/millerjl1701-ephemeris](https://millerjl1701.github.io/millerjl1701-ephemeris).

The puppet strings documentation is also included in the /docs folder.

### Public Classes

* ephemeris: Main class which installs and configures the ephemeris virtualenv. Parameters may be passed via class declaration or hiera.

### Private Classes

* ephemeris::config: Class that configures the ephemeris virtualenv by installing pip packages.
* ephemeris::install: Class that manages the installion of python, pip, python-devel, and virtualenv.

### Parameters

The ephemeris::init class has the following parameters:

```puppet
Boolean                   $manage_python            = true,
String                    $manage_python_dev        = 'present',
Boolean                   $manage_python_use_epel   = true,
String                    $manage_python_virtualenv = 'present',
Stdlib::Absolutepath      $virtualenv_dir           = '/root/ephemeris',
Enum['present', 'absent'] $virtualenv_ensure        = 'present',
String                    $virtualenv_group         = 'root',
String                    $virtualenv_mode          = '0750',
String                    $virtualenv_owner         = 'root',
Array                     $virtualenv_requirements  = [ 'ephemeris', 'bioblend', ],
```

## Limitations

The current version of Galaxy requires python 2.7. While ephemeris does not have this hard requirement, this module will be designed to setup that python version leveraging the stankevich/python puppet module. As such, this module will not work with a different module named python in your modules directory.

This module is currently supported on RHEL/CentOS 7. Support for RHEL/CentOS 6 as well as ubuntu/debian distributions will be forthcoming. Additionally, tasks will be developed to leverage the script capabilities of the ephemeris virtual environment that can be included in tasks and plans in a puppet module that manages Galaxy.

## Development

Please see the [CONTRIBUTING document](CONTRIBUTING.md) for information on how to get started developing code and submit a pull request for this module. While written in an opinionated fashion at the start, over time this can become less and less the case.

### Contributors

To see who is involved with this module, see the [GitHub list of contributors](https://github.com/millerjl1701/millerjl1701-ephemeris/graphs/contributors) or the [CONTRIBUTORS document](CONTRIBUTORS).
