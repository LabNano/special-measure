clear global;
close all;
global smdata;
load smdata_empty;

GPIB_LOCKIN = 8;
GPIB_K2400 = 24;
GPIB_HP34401A = 16;

inst_sr = smloadinst('SR830', [], 'agilent');
inst_k2400 = smloadinst('k2400', [], 'agilent');
inst_hp = smloadinst('HP34401A', [], 'agilent');

smdata.inst(inst_sr).data.inst
smdata.inst(inst_k2400).data.inst
smdata.inst(inst_hp).data.inst

%smopen(inst_sr);
%smopen(inst_k2400);
%smopen(inst_hp);


save ../rack smdata  

% useful commands for inspecting configuration (not required)
smprintinst
smprintchannels


