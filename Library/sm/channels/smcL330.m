function val = smcL330(ic, val, rate)
%Channels
%1 - 'TEMP' Temperature
%2 - 'SETP' Set Point
%3 - 'RANG' Range (0 is off)

    %Driver for LakeShore 330 Temperature Controller
    %Last update: Thiago Mattos 10-25-2024

    global smdata;
    
    switch ic(2) % Channels 
        case 1 %T
            switch ic(3); %Operation: 0 for read, 1 for write

                case 0 %read
                    val = query(smdata.inst(ic(1)).data.inst, 'KRDG?', '%s\n', '%f');

                otherwise
                    error('L331 driver: Operation not supported');
            end
            
        case 2 %S (setpoint)
            switch ic(3); %Operation: 0 for read, 1 for write

                case 0 %read
                    val = query(smdata.inst(ic(1)).data.inst, 'SETP?', '%s\n', '%f');

                case 1 %write operation; 
                    cmd = 'SETP';
                    fprintf(smdata.inst(ic(1)).data.inst, sprintf('%s %f', cmd, val));

                otherwise
                    error('L331 driver: Operation not supported');
            end
            
         case 3 %R (range)
            switch ic(3) %Operation: 0 for read, 1 for write

                case 0 %read
                    val = query(smdata.inst(ic(1)).data.inst, 'RANG?', '%s\n', '%f');

                case 1 %write operation; 
                    cmd = 'RANG';
                    fprintf(smdata.inst(ic(1)).data.inst, sprintf('%s %f', cmd, val));

                otherwise
                    error('L330 driver: Operation not supported');
            end
                 
        otherwise
            error('L330 driver: Nonvalid Channel specified');
    end
end

