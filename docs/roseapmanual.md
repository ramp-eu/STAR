### Background
The need for this ROSE-AP came from the need to get jobs sent from ERP to a STAR robotic cells database. 
An operator could then choose which job to run on which STAR robotic cell. 

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