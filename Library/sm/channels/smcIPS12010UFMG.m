function val = smcIPS12010UFMG(ico, val, rate)

% Edited by leo on Set16

% Driver for IPS12010 (GPIB version)
% settings for GPIB:
% usually board index is 0, address is 25
% can change Timeout to 1
% 6/27/2012: modified to automatically reset GPIB comm parameters with each
%           invocation.  Much safer.
%           
% 1/18/2010: modified to close and open magnet if behavior is sluggish
%           currently uses tic/toc instead of cputime because of bad
%           behavior of cputime on MX400 computer.
% 4/9/2010: added ramp support (set ramprate < 0, and use
%   scan.loops(1).trigfn.fn=@smatrigfn.  using GUI, setting
%   smscan.loops(1).trigfn.autoset=1 is enough.



global smdata;

if ico(3)==1
%     rateperminute = rate*60;
    rateperminute = rate*60; %tesla per minut
end

%ico: vector with instruemnt(index to smdata.inst), channel number for that instrument, operation
% operation: 0 - read, 1 - set , 2 - unused usually,  3 - trigger
% rate overrides default

%Might need in setup:
%channel 1: FIELD

mag = smdata.inst(ico(1)).data.inst;


% The lines bellow are important, because the IPS uses CR (\r) to end
% the byte string. So setting EOSCharCode makes the fscan stop at the
% appropriate time. Disabling this will cause read errors.
set(mag,'EOSCharCode','CR');
set(mag,'EOSMode','read');

% Use $ before commands that will not be read.
% This makes sure that wont be a queue blocking other commands
fprintf(mag, '%s\r', '$C3'); % Remote/Unlocked


switch ico(2) % Channels 

    case 1 % [standard] Magnet going to set point, then holding at set point

        switch ico(3)
            case 0 % Get

                % Ensure instrument is in remote mode
                fprintf(mag, '%s\r', '$C3'); %Remote/Unlocked

                fprintf(mag, '%s\r','X');
                state = fscanf(mag, '%s\r');

                val = NaN;
                while isnan(val)
                    if state(9) == '2' % Off Magnet at Field (switch closed)
                        fprintf(mag, '%s\r','R 18'); % Get Persistent magnet field
                        str = fscanf(mag, '%s\r');
                        val = str2double(erase(str, ["'", "R"]));
                        
                    else
                        fprintf(mag, '%s\r','R 7'); % Get Demand field (output field)
                        str = fscanf(mag, '%s\r');
                        val = str2double(erase(str, ["'", "R"]));
                    end
                    
                    % Gambiarra da fila ???
                    % val = fscanf(mag, '%*c%f');
                    % if length(val)~=1
                    %     val = NaN;
                    % end
                end
                 

            case 1 % Set 
                                  
                if abs(rateperminute) > 1 % 1 T/MIN
                    error('Magnet ramp rate too high')
                end

                % Ensure instrument is in remote mode
                fprintf(mag, '%s\r', '$C3'); %Remote/Unlocked
                
                if rateperminute < 0
                    % Set Activity to HOLD
                     fprintf(mag, '%s\r', '$A0');
                end

                % Set Field Sweep Rate
                fprintf(mag, '%s\r', ['$T' num2str(abs(rateperminute))]);


                % Read current (Demand field/output field)
                fprintf(mag, '%s\r', 'R 7');
                str = fscanf(mag, '%s\r');
                curr = str2double(erase(str, ["'", "R"]));

                % Set Target Field
                fprintf(mag, '%s\r', ['J' num2str(val)]);
                fscanf(mag, '%s\r');
                
                val = abs(val-curr)/abs(rate); 
                
                if rateperminute > 0
                    % Set Activity to HOLD
                    fprintf(mag, '%s\r', 'A1');
                    fscanf(mag, '%s\r');
                end     
                 
                 flushinput(mag);
                 flushoutput(mag);

                %Edited by leo Set14
               
                
            case 3 % Trigger
                % Set Activity to Set Point
                fprintf(mag, '%s\r', 'A1');
                fscanf(mag, '%s\r');
                
            otherwise
                error('Operation not supported');
        end
        flushinput(mag);
        flushoutput(mag);
        
    otherwise
        error('Channel not programmed');
        
end

