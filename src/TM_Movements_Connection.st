ListenNode_Connect_Enable:=TRUE;
ListenNode_Connect_IPaddress:='10.1.20.60';
ListenNode_Connect_Port:=5890;

ListenNode_Connect_Connect:=StartProgram;

ListenNode_Connect_Instance(
	Enable:=ListenNode_Connect_Enable,
	IPaddress:=ListenNode_Connect_IPaddress,
	Port:=ListenNode_Connect_Port,
	Connect:=ListenNode_Connect_Connect,
	Connected=>ListenNode_Connect_Connected,
	Error=>ListenNode_Connect_Error,
	ErrorID=>ListenNode_Connect_ErrorID,
	EtnConnError=>ListenNode_Connect_EtnConnError,
	TCP_Socket=>ListenNode_Connect_TCP_Socket,
	Socket_Status=>ListenNode_Connect_Socket_Status
);