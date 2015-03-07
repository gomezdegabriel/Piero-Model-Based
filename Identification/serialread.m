

% serialPort = serial('com1') ;
%serialPort = serial('com1', 'baudrate', 19200, 'terminator', 'CR');

oldSerial = instrfind('Port', 'COM30');  % Check to see if there are existing serial objects (instrfind) whos 'Port' property is set to 'COM1'
% can also use instrfind() with no input arguments to find ALL existing serial objects
if (~isempty(oldSerial))  % if the set of such objects is not(~) empty
    disp('WARNING:  COM30 in use.  Closing.')
    delete(oldSerial)
end
 
% creating a new serial object
ser = serial('COM30');  % Define serial port
set(ser, 'BaudRate', 9600);  % Make this match the arduino Serial Port Config
set(ser, 'Tag', 'Arduino');   % give it a name for my own reference

set(ser, 'TimeOut', .1);  %I am willing to wait 0.1 secs for data to arive
% I wanted to make my buffer only big enough to store one message
set(ser, 'InputBufferSize',  390 )

get(ser) %so you can see my result  
%%

fopen(ser) 

disp('Serial Port Initialized')


%% Flush buffer

N = ser.BytesAvailable();
while(N~=0) 
    fread(ser,N);
    N = ser.BytesAvailable();
end


%% Read data two bytes each time
data=[];
while (true)
    while ser.BytesAvailable()<2;
        pause(0.01);
    end
    a = fread(ser, 2)
    data=[data; a'];
end

%% Esto no se ejecuta nunca a menos que se detecte el fin de la recepción

fclose(ser);
clear(ser);


