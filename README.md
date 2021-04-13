## Requirements for the Mid-Term Review: [here](docs/README.md) 
<hr />

# STAR - Stitching and Taping Assisted by Robotics

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


This project is part of [DIH^2](http://www.dih-squared.eu/). For more information check the RAMP Catalogue entry for the components.

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

### Application Domain
	Bespoke, short production run acoustic panel manufacture for the automotive industry.
### Main Process
	Edge taping and edge stitching of composite acoustic panels of varying size, thickness and flexibility. 
	Process involves selection and identification of a part to be edge stitched or edge taped. The process
	centres around an integrated cobotic solution that coordinates with stitching and taping machines. 
	This is an end of line finishing process that is currently a manual process.

### Project scope
```
The system developed during the duration on the STAR project had a list of features to tick: 
 1.  Detect parts presented to it using vision.
 2.  Detect part's orientation and position. 
 3a. Using the cobot+gripper to safely pickup the part in the correct orientation.
 3b. Using the cobot, guide the part through the automated stitching machine to stitch all sides. 
 4.  Or using the cobot, guide the part through the automated taping machine to tape all sides.
 5.  Place the finished part to be picked up by operator. 
```

## Install

```text
During this project we have used Omron Sysmac Studio for PLC programming, 
Omrom TMFlow for Cobot programming and RoboDK for 3D simulation.
```
#### Sysmac Studio (PLC Programming software)
```text
A guide on how to install Omron sysmac studio could be found below: 
```
- [Sysmac Manual](https://assets.omron.eu/downloads/manual/en/v13/w504_sysmac_studio_operation_manual_en.pdf)

#### TMFlow (Cobot Programming software)
```text
A guide on how to install Omron TMFlow could be found below: 
```
- [TMFlow Manual](https://assets.omron.eu/downloads/manual/en/v8/i626_tm_flow_software_installation_manual_en.pdf)

#### RoboDK (Robot Simulation software)
```text
A guide on how to install RoboDK could be found below: 
```
- [RoboDK Manual](https://robodk.com/doc/en/Plugin-SolidWorks-Install.html)




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

#### Vision

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
