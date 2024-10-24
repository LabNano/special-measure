function val = smcK2400(ic, val, rate)
%Channels
%1 - 'V' voltage
%2 - 'I' Current
%3 - 'VRAMP' ramp voltage
%JDSY 12/6/2011 - added ramp channel and changed channel checking to be
%based off numbers

    %Driver for Keithley 2400
    %Last update: Hadar 10-13-2010
    %Error Fixed: LeoZ 8-8-2012

    global smdata;
    %strchan = smdata.inst(ic(1)).channels(ic(2),:);
    switch ic(2) % Channels 
        case 1 %V
            switch ic(3); %Operation: 0 for read, 1 for write

                case 0 %read
                    %'case 0'
                    KO = query(smdata.inst(ic(1)).data.inst, 'READ?', '%s\n', '%f,%f,%f,%f,%f');
                    val = KO(1);

                case 1 %write operation; 
                    %'case 1'
                    cmd = ':SOUR:VOLT ';
                    fprintf(smdata.inst(ic(1)).data.inst, sprintf('%s %f', cmd, val));

                otherwise
                    error('K2400 driver: Operation not supported');
            end
        case 2 %I
            switch ic(3); %Operation: 0 for read, 1 for write

            case 0 %just read voltage for now
                %'case 0'
                KO = query(smdata.inst(ic(1)).data.inst, 'READ?', '%s\n', '%f,%f,%f,%f,%f');
                val = KO(2);

            case 1 %write operation;  
                %'case 1'
                cmd = ':SOUR:CURR ';
                fprintf(smdata.inst(ic(1)).data.inst, sprintf('%s %f', cmd, val));

            otherwise
                error('K2400 driver: Operation not supported');
            end
        case 3 %VRAMP (does this channel exist?)
            if ic(3)==1 %Ramp is only a write channel
                %val,%rate
                fprintf(smdata.inst(ic(1)).data.inst, sprintf('%s %f', cmd, val));
            else
                error('K2400 driver: VRAMP channel is write-only');
            end
%                 
        otherwise
            error('K2400 driver: Nonvalid Channel specified');
    end

%         otherwise
%             error('K2400 driver: Nonvalid Channel specified');
%     end
end

