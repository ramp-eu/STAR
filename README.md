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
-   [Solution](#solution)
-   [Install](#install)
-   [Usage](#usage)
-   [API](#api)
-   [Testing](#testing)
-   [ROSEAP] (#rose-ap)
-   [License](#license)

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

During this project we have used Omron Sysmac Studio for PLC programming, 
Omrom TMFlow for Cobot programming and RoboDK for 3D simulation.

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


In order to get the system running one has to load the program backup files to the different systems.

#### PLC

- To load the PLC program open "PLC_Mastercode.smc2" with Sysmac Studio 
- Go to Controller --> Online. At the bottom right corner one would see if online with the PLC (green dot)
- To transfer the code to the PLC go to Controller --> Transfer... --> To controller and press transfer
- When prompted switch PLC to remote run. 

#### TMFLlow

- Open TM Flow 
- Double-click on the Cobot when it appears on the screen and press OK button
- Press on Get Control button
- Click on the "3 dashes" button in the top left corner and the click on the "Project" button
- Find the project named "RoboDKListenMode"
- Use cobot's remote to run the program.

#### RoboDK
 
- Open RoboDK
- Locate RoboDK project for a selected part (i.e. "2E06666.rdk")
- Double click on the Program in the File exporer to the left to simulate the program 
- If everything is fine right click on the program and click on "Send to robot"
  This will send the path plan to PLC/Cobot
- Use GUI to start the program.


#### Vision

```text
Placeholder
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

# ROSE-AP


### Background
The ROSE-AP that we developed was about getting job requests from ERP to a STAR robotic cell to execeute. 

### Solution 
The coming from the ERP would be in a CSV format. Using a CSV reader the data from the file would be published
to the ORION Context Broker as entities. These entities (jobs) would be then pushed to Crate DB and stored in a table. 
Whenever an operator initiates a start on a STAR cell from an HMI would have a table that would pull the jobs from 
Crate DB. The operator would then select a job from the list and press START. This would get the data transferred from 
the Crate DB table into the PLC. 

![ROSE-AP dataflow from ERP to PLC](https://i.ibb.co/L1v669T/ROSE-AP-1.jpg) 

Once the job is completed or stopped a report is generated in the PLC that is sent to the ERP via the Orion Context Broker. 

We are using the OPC-UA IOT agent to capture the data from the PLC tags and make them available as entities on OCB. 
They would then be able to be accessed by the ERP to update the status and quantites of a job into its own database. 

![ROSE-AP dataflow from PLC to ERP](https://i.ibb.co/dDB91Bh/ROSE-AP-2.jpg)

### Install 

### Usage

## License

[MIT](LICENSE) © <TTE>
