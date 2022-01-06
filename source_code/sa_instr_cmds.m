% RF Measurements - LAB 5 - MATLAB Code 
% Group:    James T. Robinson
%           Kaylx Jang
%           Jens Daci
%           Rishabh Kumar

%SA = visa('AGILENT', 'USB0::0x2A8D::0x0E0B::MY55360022::0::INSTR');
%SA.Timeout = 10.0;
%fopen(SA);
%fprintf(SA, '*IDN?');
%idn = fscanf(SA);

% Find a VISA-USB object.
SA = instrfind('Type', 'visa-usb', 'RsrcName', 'USB0::0x2A8D::0x0E0B::MY55360022::0::INSTR', 'Tag', '');

% Create the VISA-USB object if it does not exist
% otherwise use the object that was found.
if isempty(SA)
   SA = visa('AGILENT', 'USB0::0x2A8D::0x0E0B::MY55360022::0::INSTR');
else
   fclose(SA);
   SA = SA(1);
end
fopen(SA);

% Find a VISA-USB object.
%%
SG = instrfind('Type', 'visa-usb', 'RsrcName', 'USB0::0x0957::0x2018::0116A928::0::INSTR', 'Tag', '');
% Create the VISA-USB object if it does not exist
% otherwise use the object that was found.
if isempty(SG)
    SG = visa('AGILENT', 'USB0::0x0957::0x2018::0116A928::0::INSTR');
else
    fclose(SG);
    SG = SG(1);
end

SG.Timeout = 10.0;
% Connect to instrument object, obj1.
fopen(SG);

%%WORK SPACE

freq_arr = [0.5,1,1.5,2,2.5,3]; %Frequency values in GHz
%freq_arr = [1,3]; %Frequency values in GHz
pow_in_arr  = -25:1:4; % Input power in dB
pow_out_mat = zeros(length(freq_arr),length(pow_in_arr)); %Pout matrix
pow_out_mat_de = zeros(length(freq_arr),length(pow_in_arr)); %Gain matrix
%deembed = zeros(length(freq_arr),length(pow_in_arr)); % De-embed matrix

x = 1; % Loop counters
y = 1;

fprintf(SA, 'CALC:MARK1:STAT ON') %Setting state for marker display
fprintf(SG, 'OUTP ON') %Turning on the signal generator RF Power

% Looping through all the frequencies
for f=freq_arr
    
    sg_freq_set = sprintf('FREQ:CW %d GHz',f); %Setting SG freq
    sa_freq_set = sprintf('FREQ:CENT %d GHz',f); %Setting SA center freq
    fprintf(SG, sg_freq_set)
    fprintf(SA, sa_freq_set)
    pause(0.5)
    y=1;
    
    % Looping through the input power -25 to 4
    for pow_in=pow_in_arr
        
        sg_pow_set = sprintf('AMPL:CW %d dBm', pow_in); %Setting input power
        sa_mark_max = sprintf('CALC:MARK1:MAX'); %Marker search type to max
        sa_query_data = sprintf('CALC:MARK1:Y?'); %Getting y-axis value
        
        
        fprintf(SG, sg_pow_set) %Input power to signal generator
        pause(0.1);
        fprintf(SA, sa_mark_max) %Saving max pout
        fprintf(SA, sa_query_data)
        pause(0.1);
        
        pow_out_mat(x,y) = str2num(fscanf(SA)); %Saving pout as number
        
        y = y+1; %Loop counters
    end
    x = x+1; %Loop counters
end

pow_out_mat_de = pow_out_mat - deembed; %Saving gain by de-embedding

%deembed = pow_out_mat;

%%END WORK SPACE

fclose(SA);
fclose(SG);