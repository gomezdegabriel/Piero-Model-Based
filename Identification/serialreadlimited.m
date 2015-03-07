% Matlab program for 
ser = serial('COM30');       % Define serial port. Set to the actual COM 
set(ser, 'BaudRate', 9600);  % Make this match the arduino config
set(ser, 'TimeOut', .1);     % I am willing to wait 0.1 secs for data
get(ser)                     % so you can see my result  
%% Open Serial Port
fopen(ser); 
disp('Serial Port Initialized');
%% Flush buffer
N = ser.BytesAvailable();
while(N~=0) 
    fread(ser,N);
    N = ser.BytesAvailable();
end
%% Read data two bytes each time
data=[];
t=0;
while (t<20)  %% Set the experiment time
    while ser.BytesAvailable()<2;
        pause(0.01);
    end
    a = fread(ser, 2)
    data=[data; [t a']];
    t=t+0.2;             %% Set to the actual sampling rate
end
%% Close Serial Port
fclose(ser);