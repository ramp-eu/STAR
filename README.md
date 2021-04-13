## Requirements for the Mid-Term Review: [here](docs/README.md) 
<hr />

# <TITLE>

[![License: MIT](https://img.shields.io/github/license/ramp-eu/TTE.project1.svg)](https://opensource.org/licenses/MIT)
[![Docker badge](https://img.shields.io/docker/pulls/ramp-eu/TTE.project1.svg)](https://hub.docker.com/r/<org>/<repo>/)
<br/>
[![Documentation Status](https://readthedocs.org/projects/tte-project1/badge/?version=latest)](https://tte-project1.readthedocs.io/en/latest/?badge=latest)
[![Build badge](https://img.shields.io/travis/ramp-eu/TTE.project1.svg)](https://travis-ci.org/ramp-eu/TTE.project1/)
[![Coverage Status](https://coveralls.io/repos/github/ramp-eu/TTE.project1/badge.svg?branch=master)](https://coveralls.io/github/ramp-eu/TTE.project1?branch=master)
[![Codacy grade](https://img.shields.io/codacy/grade/99310c5c4332439197633912a99d2e3c)](https://app.codacy.com/manual/jason-fox/TTE.project1)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/4187/badge)](https://bestpractices.coreinfrastructure.org/projects/4187)

```text

The Badges above demonstrate testing, code coverage
and commitment to coding standards (since the code is linted on commit).

The links need to be amended to point to the correct repo.

Sign up for:

- CI Test system - e.g. Travis
- A Documentation website - e.g. ReadTheDocs
- Static Code Analysis tool - e.g. Codacy
- CII Best Practices https://bestpractices.coreinfrastructure.org

Only CII Best Practices (and its badge) is mandatory. Any equivalent public automated tools for the other three may be used.

Note that the CII Best Practices questionaire will request evidence of tooling used.

```

```text
One or two sentence preamble describing the element
```

This project is part of [DIH^2](http://www.dih-squared.eu/). For more information check the RAMP Catalogue entry for the
[components](https://github.com/xxx).

| :books: [Documentation](https://tte-project1.readthedocs.io/en/latest/) | :whale: [Docker Hub](https://hub.docker.com/r/link-to-docker) |
| --------------------------------------------- | ------------------------------------------------------------- |


## Contents

-   [Background](#background)
-   [Install](#install)
-   [Usage](#usage)
-   [API](#api)
-   [Testing](#testing)
-   [License](#license)

## Background

```text
Background information and links to relevant terms
```

## Install

```text

During this project we have used the Omron Sysmac Studio, Omrom TMFlow and RoboDK as the main platforms
to program the TM12 robot and control it via the Omron PLC. 
```
### Sysmac Studio (PLC Programming software)
```text
A guide on how to install Omron sysmac studio could be found below: 
```
[Sysmac Manual](https://assets.omron.eu/downloads/manual/en/v13/w504_sysmac_studio_operation_manual_en.pdf)

### TMFlow (Cobot Programming software)
```text
A guide on how to install Omron TMFlow could be found below: 
```
[TMFlow Manual](https://assets.omron.eu/downloads/manual/en/v8/i626_tm_flow_software_installation_manual_en.pdf)

### RoboDK (Robot Simulation software)
```text
A guide on how to install RoboDK could be found below: 
```
[RoboDK Manual](https://robodk.com/doc/en/Plugin-SolidWorks-Install.html)




## Usage

```text
In order to get the system running one has to load the program backup files to the different systems.
```
#### PLC
```text
 a) To load the PLC program open "PLC_Mastercode.smc2" with Sysmac Studio
 b) Go to Controller --> Online. At the bottom right corner one would see if online with the PLC (green dot)
 c) To transfer the code to the PLC go to Controller --> Transfer... --> To controller and press transfer
 d) When prompted switch PLC to remote run. 
```
#### TMFLlow
```text 
 a) Open TM Flow 
 b) Double-click on the Cobot when it appears on the screen and press OK button
 c) Press on Get Control button
 d) Click on the "3 dashes" button in the top left corner and the click on the "Project" button
 e) Find the project named "RoboDKListenMode"
 f) Use cobot's remote to run the program.
```
#### RoboDK
```text 
 a) Open RoboDK
 b) Locate RoboDK project for a selected part (i.e. "2E06666.rdk")
 c) Double click on the Program in the File exporer to the left to simulate the program 
 d) If everything is fine right click on the program and click on "Send to robot"
    This will send the path plan to PLC/Cobot
 e) Use GUI to start the program.
```

```text
Information about how to use the <Name of component> can be found in the [User & Programmers Manual](docs/usermanual.md).

The following features are listed as [deprecated](docs/deprecated.md).
```

## API

```text
Definition of the API interface:

Information about the API of  the <Name of component> can be found in the [API documentation](docs/api.md).

```

## Testing

```text
How to test the component

For performing a basic end-to-end test, you have to follow the step below. A detailed description about how to run tests can be found [here].

> npm test

```

## License

[MIT](LICENSE) © <TTE>
