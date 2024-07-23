% RDM Visualisations
clearvars all;clc;close all

% 1. Brush vs Mug vs Cubie vs Smoothie: Individual participants
% group: 0 = untrained, 1 = trained

% group = 0;
% indv_unt = plotRDM(group);
% % saveas(indv_unt, 'X:\data\mvpa\_OUTPUT\RESULTS_plots\indv_unt.png', 'png');
% 
% group = 1;
% indv_tr = plotRDM(group);
% % saveas(indv_tr, 'X:\data\mvpa\_OUTPUT\RESULTS_plots\indv_tr.png', 'png');
% 
% % 2. Trained vs Untrained: Averaged across participants
% 
% avg_all = plotRDM_AVG();
% % saveas(avg_all, 'X:\data\mvpa\_OUTPUT\RESULTS_plots\avg_all.png', 'png');

% 3. Familiar vs Unfamiliar Combined: Individual participants
% group: 0 = untrained, 1 = trained
group = 0;
combined_unt = plotRDMCombined(group);

% saveas(combined_unt, 'X:\data\mvpa\_OUTPUT\RESULTS_plots\combined_unt.png', 'png');

group = 1;
combined_tr = plotRDMCombined(group);

% saveas(combined_tr, 'X:\data\mvpa\_OUTPUT\RESULTS_plots\combined_tr.png', 'png');

% 4. Familiar vs Unfamiliar Combined: Averaged
combined_avg = plotRDMCombined_AVG();
% saveas(combined_avg, 'X:\data\mvpa\_OUTPUT\RESULTS_plots\combined_avg.png', 'png');
