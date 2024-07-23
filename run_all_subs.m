clearvars all;clc;close all

%Subject_Info = {'RBE03','IBE26','CLG22','SXG06','XHN30','ZWI22'};
%group = 'not_trained'

Subject_Info = {'AZI25','CML23','JME15','JPA10','RSG06','SKI23'};
group = 'trained'

ROI_Names = {'BOTH_SM','BOTH_MT'};

%1 - Familiar versus Unfamiliar ( Brush + Mug vs Cube + Smooth)
 
analyse_start = 1;
from_sub = 3;
to_sub = 3;
from_roi = 2;
to_roi = 2;
computeTrialsTogether = 1;
% 0 for B vs M and C vs S
% 1 for Unfamiliar vs Familiar (B + M vs C + S)

RUN_MVPA_FUNC(Subject_Info, group, ROI_Names, analyse_start, from_sub, to_sub, from_roi, to_roi, computeTrialsTogether);
clearvars -except Subject_Info; clc

%2 - Brush versus Mug
 
% analyse_start = 2;
% from_sub = 1;
% to_sub = 1;
% from_roi = 1;
% to_roi = 1;
% 
% RUN_MVPA_FUNC(Subject_Info, group, ROI_Names, analyse_start, from_sub, to_sub, from_roi, to_roi);
% clearvars -except Subject_Info; clc

%3 - Cube versus Smooth
 
%analyse_start = 3;
%from_sub = 5;
%to_sub = 6;
%from_roi = 1;
%to_roi = 2;

%RUN_MVPA_FUNC(Subject_Info, group, ROI_Names, analyse_start, from_sub, to_sub, from_roi, to_roi);
%clearvars -except Subject_Info; clc
