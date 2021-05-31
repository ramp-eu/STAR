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


