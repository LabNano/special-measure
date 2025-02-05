function val = smcL331(ic, val, rate)
%Channels
%1 - 'TMPA' Temperature on channel A
%2 - 'TMPB' Temperature on channel B
%3 - 'SETP' Set Point
%4 - 'RANG' Range (0 is off)

    %Driver for LakeShore 331 Temperature Controller
    %Last update: Thiago Mattos 11-08-2024

    global smdata;
    
    switch ic(2) % Channels 
        case 1 %T (A)
            switch ic(3); %Operation: 0 for read, 1 for write

                case 0 %read
                    val = query(smdata.inst(ic(1)).data.inst, 'KRDG? A', '%s\n', '%f');

                otherwise
                    error('L331 driver: Operation not supported');
            end

         case 2 %T (B)
            switch ic(3); %Operation: 0 for read, 1 for write

                case 0 %read
                    val = query(smdata.inst(ic(1)).data.inst, 'KRDG? B', '%s\n', '%f');

                otherwise
                    error('L331 driver: Operation not supported');
            end
            
        case 3 %S (setpoint)
            switch ic(3); %Operation: 0 for read, 1 for write

                case 0 %read
                    val = query(smdata.inst(ic(1)).data.inst, 'SETP?', '%s\n', '%f');

                case 1 %write operation; 
                    cmd = 'SETP 1';
                    fprintf(smdata.inst(ic(1)).data.inst, sprintf('%s %f', cmd, val));

                otherwise
                    error('L331 driver: Operation not supported');
            end
            
         case 4 %R (range)
            switch ic(3) %Operation: 0 for read, 1 for write

                case 0 %read
                    val = query(smdata.inst(ic(1)).data.inst, 'RANGE?', '%s\n', '%f');

                case 1 %write operation; 
                    cmd = 'RANGE';
                    fprintf(smdata.inst(ic(1)).data.inst, sprintf('%s %f', cmd, val));

                otherwise
                    error('L331 driver: Operation not supported');
            end
                 
        otherwise
            error('L331 driver: Nonvalid Channel specified');
    end
end

