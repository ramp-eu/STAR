

# STAR - Stitching and Taping Assisted by Robotics

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Docker badge](https://img.shields.io/docker/pulls/ramp-eu/TTE.project1.svg)](https://hub.docker.com/r/<org>/<repo>/)
<br/>
[![Documentation Status](https://readthedocs.org/projects/star1/badge/?version=latest)](https://star1.readthedocs.io/en/latest/?badge=latest)
[![Build badge](https://img.shields.io/travis/ramp-eu/TTE.project1.svg)](https://travis-ci.org/ramp-eu/TTE.project1/)
[![Coverage Status](https://coveralls.io/repos/github/ramp-eu/TTE.project1/badge.svg?branch=master)](https://coveralls.io/github/ramp-eu/TTE.project1?branch=master)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/05c7057c982b491390f725c319f6f2ec)](https://www.codacy.com/gh/ramp-eu/STAR/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=ramp-eu/STAR&amp;utm_campaign=Badge_Grade)
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
-   [Feedback](#feedback)
-   [Contribution](#contribution)
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


Information about how to install the component can be found at the corresponding section of the
[Installation & Administration Guide](docs/installationguide.md).


## Usage


Information about how to use the component can be found in the [User & Programmers Manual](docs/usermanual.md).


## Testing

### Concept testing

In order to test the full potential of this proejct one would have to have Omron TM12 Cobot, Omron PLC rack and an Addler stitching machine. 
As this is unlikely to be the case in this section we will explain how to test the Digital Twin section of the project. This will give you an idea of what the project is all about. 
For this you will have to have RoboDK installed on your PC. Once RoboDK is installed go to "src" folder of the repo and open the RoboDK project (2E06666.rdk).
Once the project is open you'd see a table with stitching machine and cobot on it, and the test part to be stitched.
On the left also there will be a file explorer like tree. It consists of few items. The reference frame where the robot is located, the Tool reference frame, The Table 3D object and the program called Prog1. 
The program conists of Movements and IO commands. The Movements are of 2 types (MoveJ and MoveL). The MoveJ commands would get the cobot to go from Point A to Point B in the quickest and best way for the robot. 
The MoveL moves the cobot's End of Arm Tooling in a stright line from A to B. This is essential when operating close to the robot and helps prevent collissions. To start the Digital Twin's program double-click on "Prog1" and you'd see the program beign executed. 

### Rig testing

If there is a test rig aviaiable (i.e. OMRON TM12 Cobot, Omron PLC rack, Addler Stitcher) one can follow the steps below: 
1. Connect all the machines to a local network switch
2. Power everythign on.
3. Reset any E-stops on the Cobot. 
4. Open TMFlow software and load the project called RoboDKListen.
5. Make sure the Omron PLC is online, running and has the backup from the src folder uploaded onto it. 
6. In RoboDK right-click on the Program and make sure you select the "CSV" post processor. (Although it should be already selected). 
7. Run the program in RoboDK and make sure it is safe to be transferred to the Robot. 
8. Finally send the program to the robot by right-clicking on the program and then "Send program to Robot"

## ROSE-AP

Information about how to install & use the component can be found in the [ROSE-AP Manual](docs/roseapmanual.md).


## Feedback

Any feedback and suggestions can be submitted by creating New issue in the Issues tab or by emailing the team. 

## Contribution

In order to contribute you will have to request to be added to the project. 

## License

The project is licensed under the [Apache-2](https://opensource.org/licenses/Apache-2.0) license.
