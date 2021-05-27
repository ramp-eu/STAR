

# STAR - Stitching and Taping Assisted by Robotics

[![License: MIT](https://img.shields.io/github/license/ramp-eu/TTE.project1.svg)](https://opensource.org/licenses/MIT)
[![Docker badge](https://img.shields.io/docker/pulls/ramp-eu/TTE.project1.svg)](https://hub.docker.com/r/<org>/<repo>/)
<br/>
[![Documentation Status](https://readthedocs.org/projects/tte-project1/badge/?version=latest)](https://tte-project1.readthedocs.io/en/latest/?badge=latest)
[![Build badge](https://img.shields.io/travis/ramp-eu/TTE.project1.svg)](https://travis-ci.org/ramp-eu/TTE.project1/)
[![Coverage Status](https://coveralls.io/repos/github/ramp-eu/TTE.project1/badge.svg?branch=master)](https://coveralls.io/github/ramp-eu/TTE.project1?branch=master)
[![Codacy grade](https://img.shields.io/codacy/grade/99310c5c4332439197633912a99d2e3c)](https://app.codacy.com/manual/jason-fox/TTE.project1)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/4883/badge)](https://bestpractices.coreinfrastructure.org/projects/4883)


This project is part of [DIH^2](http://www.dih-squared.eu/). For more information check the RAMP Catalogue entry for the components.

| :books: [Documentation](https://tte-project1.readthedocs.io/en/latest/) | :whale: [Docker Hub](https://hub.docker.com/r/link-to-docker) |
| --------------------------------------------- | ------------------------------------------------------------- |


## Contents

-   [Background](#background)
-   [Solution](#solution)
-   [Install](#install)
-   [Usage](#usage)
-   [API](#api)
-   [Testing](#testing)
-   [ROSE AP](#rose-ap)
-   [License](#license)
-   [Feedback](#feedback)
-   [Contribution](#contribution)

## Background

### Application Domain
Bespoke, short production run acoustic panel manufacture for the automotive industry.
### Main Process
Edge taping and edge stitching of composite acoustic panels of varying size, thickness and flexibility. 
Process involves selection and identification of a part to be edge stitched or edge taped. The process
centres around an integrated cobotic solution that coordinates with stitching and taping machines. 
This is an end of line finishing process that is currently a manual process.

### Use Case Needs / Agility Challenge Description

Use Case Needs: - Automation of the end of line finishing to increase production capability and make
allowances for a diminishing skill set related to stitching in particular.

Agility Challenges: The SME has a wide range of profiles based on their business model of bespoke, 
short run acoustic profiles. This presents a number of agility challenges:

 1. Capability to quickly recall and identify the particular part
 2. Capability to quickly recall the planned paths corresponding to the part
 3. Picking and presenting parts from random locations
 4. Coordination of the stitching and taping with the robotics paths


### Main Objectives
	
The main objective of this project is to digitise and install an automated robotic solution to a process
that up to now has been totally manual. So in essence to employ an additional line of assembly that 
requires less skilled operators to support the performance of tasks that have normally been reserved 
for more skilled operatives. The experiment sought to explore the capabilities of integrating available 
technology to adapt to variances associated with bespoke, short run manufacture. Focus has been placed 
on digital simulation, vision system support and repeatability of cobotic paths to perform 
detailed stitching/ taping paths.

## Solution

![STAR Module Architecture Diagram](https://i.ibb.co/TqqhDgh/star-arch.jpg) 

Our solution consists the deployment of a single Techman 12 cobot mounted on a large table with two defined
spaces (vision system selection area and stitching/ taping area). The function of the is to pick (using a vacuum
gripper) the acoustic parts from selection area, present the part to a stitching machine or taping machine. The
robot then guides the part through either machine while a coordinated operation edge tapes or stitches the part.
Finally, the cobot will place the part down for manual removal and QC checks.


## Install


Information about how to install the component can be found at the corresponding section of the
[Installation & Administration Guide](docs/installationguide.md).


## Usage


Information about how to use the component can be found in the [User & Programmers Manual](docs/usermanual.md).


## Testing

```text
How to test the component

For performing a basic end-to-end test, you have to follow the step below. A detailed description about how to run tests can be found [here].

> npm test

```

## ROSE-AP

Information about how to install & use the component can be found in the [ROSE-AP Manual](docs/roseapmanual.md).


## Feedback

Any feedback and suggestions can be going to the Issues tab and creating New Issue.

## Contribution

In order to contribute you will have to request to be added to the project. 

## License

[MIT](LICENSE) © <TTE>