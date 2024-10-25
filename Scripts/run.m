global smdata;
load rack;

smopen;

fprintf(smdata.inst(sminstlookup("K2400")).data.inst,'*RST');
fprintf(smdata.inst(sminstlookup("K2400")).data.inst,':sour:func volt');
fprintf(smdata.inst(sminstlookup("K2400")).data.inst,':sour:volt:rang 200'); % Cmpl blinks if rang is not defined
fprintf(smdata.inst(sminstlookup("K2400")).data.inst,':sens:curr:prot 100e-6');
fprintf(smdata.inst(sminstlookup("K2400")).data.inst,':sens:curr:rang 100e-6'); % Cmpl blinks if rang is not defined
fprintf(smdata.inst(sminstlookup("K2400")).data.inst,':outp on');  

smgui_small;