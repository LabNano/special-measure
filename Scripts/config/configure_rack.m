clear global;
close all;
global smdata;
load smdata_empty;

inst_sr = smloadinst('SR830', [], 'agilent');
inst_k2400 = smloadinst('k2400', [], 'agilent');
inst_hp = smloadinst('HP34401A', [], 'agilent');
inst_L330 = smloadinst('L330', [], 'agilent');

smdata.inst(inst_sr).data.inst
smdata.inst(inst_k2400).data.inst
smdata.inst(inst_hp).data.inst
smdata.inst(inst_L330).data.inst

% load dummy instrument
smloadinst('test')         
smaddchannel('test', 'CH1', 'dummy');
smaddchannel('test', 'CH2', 'count');

%smopen(inst_sr);
%smopen(inst_k2400);
%smopen(inst_hp);


save ../rack smdata  

% useful commands for inspecting configuration (not required)
smprintinst
smprintchannels


