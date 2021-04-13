DU_Enable(Clk:=Enable);
DD_ListenNode_Connect_Connected(Clk:=ListenNode_Connect_Connected);
DD_CableConnected(Clk:=CableConnected);

Enable:=StartProgram;


IF DU_Enable.Q THEN
	
	Stage:=0;
	MovementIndicatorStage:=0;
	Proj_Rob_Speed:= 65;
	
END_IF;

IF DD_ListenNode_Connect_Connected.Q OR DD_CableConnected.Q THEN //connection closed or cable disconnected.
	
	Stage:= 9999; //MovementIndicatorStage;
	
END_IF;

IF Enable AND ListenNode_Connect_Connected AND CableConnected  THEN	//the PLC program is enabled and there is connection with listen node and the cable is connected
	 
	CASE Stage OF
				
		//-----------------------------------------------------------TCP Selection--------------------------------------------------
		0:
			TM_ChangeTCP_Enable:=FALSE;
			IF (NOT TM_ChangeTCP_Done) AND (NOT TM_ChangeTCP_Error) AND (NOT TM_ChangeTCP_Busy) THEN
				//FileName:= 'Prog1';
				//RoboDKLoad:=1;
				Stage:=1; 
			END_IF;
		1:	
			
			TM_ChangeTCP_Enable:=TRUE;	
			TM_ChangeTCP_ActivateExit:=TRUE;
			TM_ChangeTCP_CommandID:=1;
			TM_ChangeTCP_Execute:=FALSE;
			TM_ChangeTCP_ListenNode:='Listen1';
			TM_ChangeTCP_TCP:='Gripper';
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			TM_ChangeTCP_Weight:='';
			TM_ChangeTCP_MomInertia:='';
			TM_ChangeTCP_RefFrame:='';
			TM_ChangeLoad_Payload:='';
			
			IF (NOT TM_ChangeTCP_Done) AND (NOT TM_ChangeTCP_Error) THEN
				
				Stage:=2;
				
			END_IF;
		2:
			TM_ChangeTCP_Execute:=TRUE;
			IF TM_ChangeTCP_Done THEN
				Stage:=10;
			ELSIF TM_ChangeTCP_Error THEN
				Stage:=9999;
			END_IF;
		//-----------------------------------------------------------Program Stages--------------------------------------------------------------
		10:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=11;
			END_IF;
		11:	
			StepMove:=1;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:= 'PTP';
			TM_MovCmd_Movement:= MovType[1];  //'PTP';
			IF MovType[1] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[1];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[1] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[1];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=12;
			END_IF;
		12:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 1 THEN
				
				Stage:=20;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;
		///////////////////////////////////////////////////////////////////////////////////////////////
		20:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=21;
			END_IF;
		21:			
			StepMove:=2;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[2];
			IF MovType[2] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[2];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=0;
			TM_MovCmd_RobotPose:='';
			IF VarIO[2] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[2];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=22;
			END_IF;			
		22:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 2 THEN
				//////////////////////////////
				Stage:=30;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;
		///////////////////////////////////////////////////////////////////////////////////////////////
		30:
			TM_MovCmd_Enable:=FALSE;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=31;
			END_IF;
		31:			
			StepMove:=3;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[3];
			IF MovType[3] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[3];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[3] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[3];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=32;
			END_IF;
		
		32:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 3 THEN
				Stage:=40;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;
		///////////////////////////////////////////////////////////////////////////////////////////////	
		40:
			TM_MovCmd_Enable:=FALSE;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=41;
			END_IF;	
		41:
			StepMove:=4;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[4];
			IF MovType[4] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[4];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[4] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[4];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=42;
			END_IF;
		42:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 4 THEN
				Stage:=50;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;
		///////////////////////////////////////////////////////////////////////////////////////////////
		50:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=51;
			END_IF;	
		
		51:
			StepMove:=5;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[5];
			IF MovType[5] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[5];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[5] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[5];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=52;
			END_IF;
		52:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 5 THEN
				Stage:=60;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;
		///////////////////////////////////////////////////////////////////////////////////////////////	
		60:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=61;
			END_IF;	
		
		61:
			StepMove:=6;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[6];
			IF MovType[6] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[6];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=0;
			TM_MovCmd_RobotPose:='';
			IF VarIO[6] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[6];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=62;
			END_IF;
		62:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 6 THEN
				Stage:=70;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;
		///////////////////////////////////////////////////////////////////////////////////////////////
		70:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=71;
			END_IF;	
		
		71:
			StepMove:=7;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[7];
			IF MovType[7] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[7];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=0;
			TM_MovCmd_RobotPose:='';
			IF VarIO[7] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[7];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=72;
			END_IF;
		72:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 7 THEN
				Stage:=80;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;
		///////////////////////////////////////////////////////////////////////////////////////////////
		80:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=81;
			END_IF;	
		
		81:
			StepMove:=8;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[8];
			IF MovType[8] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[8];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[8] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[8];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=82;
			END_IF;
		82:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 8 THEN
				Stage:=90;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;	
			///////////////////////////////////////////////////////////////////////////////////////////////
		90:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=91;
			END_IF;	
		
		91:
			StepMove:=9;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[9];
			IF MovType[9] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[9];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[9] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[9];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=92;
			END_IF;
		92:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 9 THEN
				Stage:=100;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;
			///////////////////////////////////////////////////////////////////////////////////////////////
			100:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=101;
			END_IF;	
		
		101:
			StepMove:=10;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[10];
			IF MovType[10] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[10];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[10] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[10];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=102;
			END_IF;
		
		102:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 10 THEN
				Stage:=110;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;
			///////////////////////////////////////////////////////////////////////////////////////////////
			110:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=111;
			END_IF;	
		
		111:
			StepMove:=11;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[11];
			IF MovType[11] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[11];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[11] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[11];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=112;
			END_IF;
		112:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 11 THEN
				Stage:=120;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;
		120:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=121;
			END_IF;	
		
		121:
			StepMove:=12;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[12];
			IF MovType[12] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[12];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[12] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[12];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=122;
			END_IF;
		122:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 12 THEN
				Stage:=130;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;	
			///////////////////////////////////////////////////////////////////////////////////////////////
		130:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=131;
			END_IF;	
		
		131:
			StepMove:=13;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[13];
			IF MovType[13] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[13];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[13] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[13];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=132;
			END_IF;
		132:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 13 THEN
				Stage:=140;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;
			
		140:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=141;
			END_IF;	
		
		141:
			StepMove:=14;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[14];
			IF MovType[14] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[14];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[14] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[14];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=142;
			END_IF;
		
		142:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 14 THEN
				Stage:=150;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;
			///////////////////////////////////////////////////////////////////////////////////////////////
		150:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=151;
			END_IF;	
		
		151:
			StepMove:=15;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[15];
			IF MovType[15] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[15];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[15] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[15];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=152;
			END_IF;
		152:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 15 THEN
				Stage:=160;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;
			
		160:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=161;
			END_IF;	
		
		161:
			StepMove:=16;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[16];
			IF MovType[16] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[16];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[16] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[16];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=162;
			END_IF;
		162:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 16 THEN
				Stage:=170;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;
		170:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=171;
			END_IF;	
		
		171:
			StepMove:=17;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[17];
			IF MovType[17] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[17];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[17] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[17];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=172;
			END_IF;
		172:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 17 THEN
				Stage:=180;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;		
		180:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=181;
			END_IF;	
		
		181:
			StepMove:=18;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[18];
			IF MovType[18] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[18];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[18] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[18];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=182;
			END_IF;
		182:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 18 THEN
				Stage:=190;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;	
		190:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=191;
			END_IF;	
		
		191:
			StepMove:=19;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[19];
			IF MovType[19] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[19];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[19] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[19];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=192;
			END_IF;
		192:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 19 THEN
				Stage:=200;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;		
		200:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=201;
			END_IF;	
		
		201:
			StepMove:=20;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[20];
			IF MovType[20] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[20];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[20] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[20];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=202;
			END_IF;
		202:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 20 THEN
				Stage:=210;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;		
		210:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=211;
			END_IF;	
		
		211:
			StepMove:=21;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[21];
			IF MovType[21] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[21];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[21] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[21];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=212;
			END_IF;
		212:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 21 THEN
				Stage:=220;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;		
		220:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=221;
			END_IF;	
		
		221:
			StepMove:=22;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[22];
			IF MovType[22] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[22];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[22] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[22];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=222;
			END_IF;
		222:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 22 THEN
				Stage:=230;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;	
		230:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=231;
			END_IF;	
		
		231:
			StepMove:=23;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[23];
			IF MovType[23] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[23];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[23] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[23];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=232;
			END_IF;
		232:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 23 THEN
				Stage:=240;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;	
		240:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=241;
			END_IF;	
		
		241:
			StepMove:=24;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[24];
			IF MovType[24] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[24];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[24] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[24];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=242;
			END_IF;
		242:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 24 THEN
				Stage:=250;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;				
		250:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=251;
			END_IF;	
		
		251:
			StepMove:=25;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[25];
			IF MovType[25] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[25];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[25] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[25];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=252;
			END_IF;
		252:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 25 THEN
				Stage:=260;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;				
		260:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=261;
			END_IF;	
		
		261:
			StepMove:=26;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[26];
			IF MovType[26] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[26];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[26] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[26];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=262;
			END_IF;
		262:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 26 THEN
				Stage:=270;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;		
		270:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=271;
			END_IF;	
		
		271:
			StepMove:=27;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[27];
			IF MovType[27] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[27];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[27] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[27];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=272;
			END_IF;
		272:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 27 THEN
				Stage:=280;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;			
		280:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=281;
			END_IF;	
		
		281:
			StepMove:=28;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[28];
			IF MovType[28] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[28];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[28] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[28];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=282;
			END_IF;
		282:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 28 THEN
				Stage:=290;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;	
		290:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=291;
			END_IF;	
		
		291:
			StepMove:=29;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[29];
			IF MovType[29] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[29];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[29] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[29];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=292;
			END_IF;
		292:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 29 THEN
				Stage:=300;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;				
		300:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=301;
			END_IF;	
		
		301:
			StepMove:=30;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[30];
			IF MovType[30] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[30];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[30] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[30];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=302;
			END_IF;
		302:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 30 THEN
				Stage:=310;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;		
		310:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=311;
			END_IF;	
		
		311:
		    StepMove:=31;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[31];
			IF MovType[31] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[31];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[31] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[31];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=312;
			END_IF;
		312:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 31 THEN
				Stage:=320;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;		
		320:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=321;
			END_IF;	
		
		321:
			StepMove:=32;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[32];
			IF MovType[32] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[32];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[32] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[32];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=322;
			END_IF;
		322:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 32 THEN
				Stage:=330;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;	
		330:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=331;
			END_IF;	
		
		331:
			StepMove:=33;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[33];
			IF MovType[33] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[33];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[33] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[33];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=332;
			END_IF;
		332:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 33 THEN
				Stage:=340;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;	
		340:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=341;
			END_IF;	
		
		341:
			StepMove:=34;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[34];
			IF MovType[34] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[34];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[34] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[34];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=342;
			END_IF;
		342:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 34 THEN
				Stage:=350;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;				
		350:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=351;
			END_IF;	
		
		351:
			StepMove:=35;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[35];
			IF MovType[35] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[35];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[35] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[35];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=352;
			END_IF;
		352:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 35 THEN
				Stage:=360;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;				
		360:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=361;
			END_IF;	
		
		361:
			StepMove:=36;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[36];
			IF MovType[36] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[36];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[36] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[36];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=362;
			END_IF;
		362:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 36 THEN
				Stage:=370;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;		
		370:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=371;
			END_IF;	
		
		371:
			StepMove:=37;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[37];
			IF MovType[37] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[37];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[37] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[37];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=372;
			END_IF;
		372:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 37 THEN
				Stage:=380;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;			
		380:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=381;
			END_IF;	
		
		381:
			StepMove:=38;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[38];
			IF MovType[38] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[38];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[38] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[38];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=382;
			END_IF;
		382:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 38 THEN
				Stage:=390;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;	
		390:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=391;
			END_IF;	
		
		391:
			StepMove:=39;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[39];
			IF MovType[39] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[39];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[39] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[39];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=392;
			END_IF;
		392:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 39 THEN
				Stage:=400;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;	
		400:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=401;
			END_IF;	
		
		401:
			StepMove:=40;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[40];
			IF MovType[40] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[40];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[40] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[40];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=402;
			END_IF;
		402:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 40 THEN
				Stage:=410;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;		
		410:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=411;
			END_IF;	
		
		411:
			StepMove:=41;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[41];
			IF MovType[41] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[41];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[41] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[41];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=412;
			END_IF;
		412:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 41 THEN
				Stage:=420;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;		
		420:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=421;
			END_IF;	
		
		421:
			StepMove:=42;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[42];
			IF MovType[42] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[42];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[42] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[42];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=422;
			END_IF;
		422:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 42 THEN
				Stage:=430;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;	
		430:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=441;
			END_IF;	
		
		431:
			StepMove:=43;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[43];
			IF MovType[43] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[43];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[43] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[43];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=432;
			END_IF;
		432:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 43 THEN
				Stage:=440;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;	
		440:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=441;
			END_IF;	
		
		441:
			StepMove:=44;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[44];
			IF MovType[44] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[44];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[44] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[44];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=442;
			END_IF;
		442:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 44 THEN
				Stage:=450;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;				
		450:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=451;
			END_IF;	
		
		451:
			StepMove:=45;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[45];
			IF MovType[45] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[45];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[45] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[45];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=452;
			END_IF;
		452:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 45 THEN
				Stage:=460;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;				
		460:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=461;
			END_IF;	
		
		461:
			StepMove:=46;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[46];
			IF MovType[46] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[46];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[46] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[46];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=462;
			END_IF;
		462:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 46 THEN
				Stage:=470;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;		
		470:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=471;
			END_IF;	
		
		471:
			StepMove:=47;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[47];
			IF MovType[47] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[47];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[47] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[47];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=472;
			END_IF;
		472:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 47 THEN
				Stage:=480;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;			
		480:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=481;
			END_IF;	
		
		481:
			StepMove:=48;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[48];
			IF MovType[48] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[48];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[48] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[48];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=482;
			END_IF;
		482:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 48 THEN
				Stage:=490;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;	
		490:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=491;
			END_IF;	
		
		491:
			StepMove:=49;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[49];
			IF MovType[49] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[49];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[49] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[49];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=492;
			END_IF;
		492:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 49 THEN
				Stage:=500;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;				
		500:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=501;
			END_IF;	
		
		501:
			StepMove:=50;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[50];
			IF MovType[50] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[50];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[50] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[50];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=502;
			END_IF;
		502:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done AND Index_STR > 50 THEN
				Stage:=510;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;		
		510:
			TM_MovCmd_Enable:=FALSE;
			MovementIndicatorStage:=Stage;
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) AND (NOT TM_MovCmd_Busy) THEN
				Stage:=511;
			END_IF;	
		
		511:
			StepMove:=51;
			TM_MovCmd_Enable:=TRUE;
			TM_MovCmd_Movement:=MovType[51];
			IF MovType[51] = 'PTP'  THEN
			TM_MovCmd_DataFormat:='CPP';
			ELSE TM_MovCmd_DataFormat:='CPR';
			END_IF;
			TM_MovCmd_Point:=Position[51];
			TM_MovCmd_Speed:=Proj_Rob_Speed;
			TM_MovCmd_AccelTime:=200;
			TM_MovCmd_Blending:=0;
			TM_MovCmd_PrecisePos:=1;
			TM_MovCmd_RobotPose:='';
			IF VarIO[51] = '' THEN
			TM_MovCmd_Command:='var_switch=10'; //10 = pass; 20 = start stitching; 30 = stop stithing; 40 = gripper on; 50 = gripper off
			ELSE TM_MovCmd_Command:=VarIO[51];
			END_IF;
			TM_MovCmd_ActivateExit:=TRUE;
			TM_MovCmd_CommandID:=1;
			TM_MovCmd_Execute:=FALSE;
			TM_MovCmd_ListenNode:='Listen1';
		
			IF (NOT TM_MovCmd_Done) AND (NOT TM_MovCmd_Error) THEN
				Stage:=512;
			END_IF;
		512:
			TM_MovCmd_Execute:=TRUE;
			IF TM_MovCmd_Done THEN
				Stage:=9999;
			ELSIF TM_MovCmd_Error THEN
				Stage:=9999;
			END_IF;		

	END_CASE;
	
END_IF;

		//Stitching control based on robot absolute position
		
		IF RobotIO.ControlBox.DO0 = 1  AND StartProgram = 1 THEN 
	  			Run_Stiching:=1;
				Run_Stiching_Man:=0;
				Stitcher_AutoSpeed:=1;
		ELSIF RobotIO.ControlBox.DO0 = 0 AND StartProgram = 1 THEN
				Run_Stiching:=1;
				Run_Stiching_Man:=0;
				Stitcher_AutoSpeed:=0;
			    Speed:= -2;
		END_IF;

TM_MovCmd_Instance(
	Done=>TM_MovCmd_Done,
	Busy=>TM_MovCmd_Busy,
	Error=>TM_MovCmd_Error,
	ErrorID=>TM_MovCmd_ErrorID,
	Execute:=TM_MovCmd_Execute,
	RobotID:=ListenNode_Connect_TCP_Socket,
	Movement:=TM_MovCmd_Movement,
	DataFormat:=TM_MovCmd_DataFormat,
	Point:=TM_MovCmd_Point,
	Speed:=TM_MovCmd_Speed,
	AccelTime:=TM_MovCmd_AccelTime,
	Blending:=TM_MovCmd_Blending,
	PrecisePos:=TM_MovCmd_PrecisePos,
	RobotPose:=TM_MovCmd_RobotPose,
	Command:=TM_MovCmd_Command,  
	ActivateExit:=TM_MovCmd_ActivateExit,
	CommandID:=TM_MovCmd_CommandID,
	TimeOut:=T#3600s,
	ListenNode:=TM_MovCmd_ListenNode,
	TimeOutET=>TM_MovCmd_TimeOutET,
	Enable:=TM_MovCmd_Enable
);

TM_ChangeTCP_Instance(
	Enable:=TM_ChangeTCP_Enable,
	Execute:=TM_ChangeTCP_Execute,
	RobotID:=ListenNode_Connect_TCP_Socket,
	TCP:=TM_ChangeTCP_TCP,
	Weight:=TM_ChangeTCP_Weight,
	MomInertia:=TM_ChangeTCP_MomInertia,
	RefFrame:=TM_ChangeTCP_RefFrame,
	Command:=TM_ChangeTCP_Command,
	ActivateExit:=TM_ChangeTCP_ActivateExit,
	ListenNode:=TM_ChangeTCP_ListenNode,
	TimeOut:=T#3600s,
	CommandID:=TM_ChangeTCP_CommandID,
	Done=>TM_ChangeTCP_Done,
	Busy=>TM_ChangeTCP_Busy,
	Error=>TM_ChangeTCP_Error,
	ErrorID=>TM_ChangeTCP_ErrorID,
	TimeOutET=>TM_ChangeTCP_TimeOutET
);

TM_ChangeLoad_Instance(
	Enable:=TM_ChangeLoad_Enable,
	Execute:=TM_ChangeLoad_Execute,
	RobotID:=ListenNode_Connect_TCP_Socket,
	Payload:=TM_ChangeLoad_Payload,
	Command:=TM_ChangeLoad_Command,
	ActivateExit:=TM_ChangeLoad_ActivateExit,
	ListenNode:=TM_ChangeLoad_ListenNode,
	TimeOut:=T#3600s,
	CommandID:=TM_ChangeLoad_CommandID,
	Done=>TM_ChangeLoad_Done,
	Busy=>TM_ChangeLoad_Busy,
	Error=>TM_ChangeLoad_Error,
	ErrorID=>TM_ChangeLoad_ErrorID,
	TimeOutET=>TM_ChangeLoad_TimeOutET
);

TM_CircleCmd_Instance(
	Enable:=TM_CircleCmd_Enable,
	Execute:=TM_CircleCmd_Execute,
	RobotID:=ListenNode_Connect_TCP_Socket,
	DataFormat:=TM_CircleCmd_DataFormat,
	ArcPoint:=TM_CircleCmd_ArcPoint,
	EndArcPoint:=TM_CircleCmd_EndArcPoint,
	Speed:=TM_CircleCmd_Speed,
	AccelTime:=TM_CircleCmd_AccelTime,
	Blending:=TM_CircleCmd_Blending,
	ArcAngle:=TM_CircleCmd_ArcAngle,
	PrecisePos:=TM_CircleCmd_PrecisePos,
	Command:=TM_CircleCmd_Command,
	ActivateExit:=TM_CircleCmd_ActivateExit,
	ListenNode:=TM_CircleCmd_ListenNode,
	TimeOut:=T#3600s,
	CommandID:=TM_CircleCmd_CommandID,
	Done=>TM_CircleCmd_Done,
	Busy=>TM_CircleCmd_Busy,
	Error=>TM_CircleCmd_Error,
	ErrorID=>TM_CircleCmd_ErrorID,
	TimeOutET=>TM_CircleCmd_TimeOutET
);

TM_ChangeBase_Instance(
	Enable:=TM_ChangeBase_Enable,
	Execute:=TM_ChangeBase_Execute,
	RobotID:=ListenNode_Connect_TCP_Socket,
	Base:=TM_ChangeBase_Base,
	Command:=TM_ChangeBase_Command,
	ActivateExit:=TM_ChangeBase_ActivateExit,
	ListenNode:=TM_ChangeBase_ListenNode,
	TimeOut:=T#3600s,
	CommandID:=TM_ChangeBase_CommandID,
	Done=>TM_ChangeBase_Done,
	Busy=>TM_ChangeBase_Busy,
	Error=>TM_ChangeBase_Error,
	ErrorID=>TM_ChangeBase_ErrorID,
	TimeOutET=>TM_ChangeBase_TimeOutET
);

