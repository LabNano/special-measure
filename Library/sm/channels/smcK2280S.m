function val = smcK2280S(ic, val, rate)
%Channels
%1 - 'V' voltage
%2 - 'I' Current

    %Driver for Keithley 2080S
    %Last update: Thiago Mattos 11-19-2024

    global smdata;
    %strchan = smdata.inst(ic(1)).channels(ic(2),:);
    switch ic(2) % Channels 
        case 1 %V
            switch ic(3); %Operation: 0 for read, 1 for write

                case 0 %read
                    KO = query(smdata.inst(ic(1)).data.inst, ':READ1?', '%s\n', '%s\n');
                    parts = strsplit(KO, ',');
                    parts = parts{2};
                    val = str2double(parts(1:end-1));

                case 1 %write operation; 
                    cmd = ':SOUR:VOLT ';
                    fprintf(smdata.inst(ic(1)).data.inst, sprintf('%s %f', cmd, val));

                otherwise
                    error('K2400 driver: Operation not supported');
            end
        case 2 %I
            switch ic(3); %Operation: 0 for read, 1 for write

            case 0 %just read voltage for now
                    KO = query(smdata.inst(ic(1)).data.inst, ':READ1?', '%s\n', '%s\n');
                    parts = strsplit(KO, ',');
                    parts = parts{1};
                    val = str2double(parts(1:end-1));

            otherwise
                error('K2400 driver: Operation not supported');
            end

        otherwise
            error('K2400 driver: Nonvalid Channel specified');
    end
end

