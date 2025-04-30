clear global;
close all;
global smdata;
load smdata_empty;
inst_IPS12010 = smloadinst('IPS120-10_UFMG', [], 'agilent');
% inst_srA = smloadinst('SR830A', [], 'agilent');
% inst_srB = smloadinst('SR830B', [], 'agilent');
% inst_k2400 = smloadinst('k2400', [], 'agilent');
% inst_hp = smloadinst('HP34401A', [], 'agilent');
% inst_k2400B = smloadinst('k2400B', [], 'agilent');
% inst_L330 = smloadinst('L331', [], 'agilent');
% inst_k2000 = smloadinst('K2000', [], 'agilent');


% smdata.inst(inst_srA).data.inst
% smdata.inst(inst_srB).data.inst
% smdata.inst(inst_k2400).data.inst
% smdata.inst(inst_hp).data.inst
% smdata.inst(inst_k2000).data.inst
% smdata.inst(inst_k2400B).data.inst
% smdata.inst(inst_L330).data.inst
smdata.inst(inst_IPS12010).data.inst

% load dummy instrument
smloadinst('test')         
smaddchannel('test', 'CH1', 'dummy');
smaddchannel('test', 'CH2', 'count');
smopen(inst_IPS12010)
% smopen(inst_srA);
% smopen(inst_srB);
% smopen(inst_k2400);
% smopen(inst_hp);
% smopen(inst_k2000);
% smopen(inst_k2400B);

save ../rack smdata  

% useful commands for inspecting configuration (not required)
smprintinst
smprintchannels


