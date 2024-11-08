%% Generate instrument files with correct GPIB port, connecting using VISA.
%% Always run this file from its folder!

load("visa_constructor.mat")

%% Generate SR830
load('sminst_SR830.mat', 'inst')
inst.name = 'Lockin A';
constructor.args = {'GPIB0::8'};
save('./sminst_SR830.mat', 'constructor', 'inst')


%% Generate Lake shore 330
load('sminst_L331.mat', 'inst')
inst.name = 'L331';
constructor.args = {'GPIB0::20'};
save('./sminst_L331.mat', 'constructor', 'inst')

%% Generate k2400
load('sminst_K2400.mat', 'inst') % or sminst_Keithley2400.mat
inst.name = 'K2400';
constructor.args = {'GPIB0::24'};
save('./sminst_k2400.mat', 'constructor', 'inst')


%% Generate HP34401A
load('sminst_HP34401A.mat', 'inst')
inst.name = 'DMM HP34401A';
constructor.args = {'GPIB0::16'};
save('./sminst_HP34401A.mat', 'constructor', 'inst')