% MWW TEST AND BOOTSTRAPPED RESULTS + VISUALISATIONS
clearvars all;clc;close all

% ---------- load files
[untrainedMT, untrainedSM, trainedMT, trainedSM] = files_by_ROI_TRAIN();

% --------- get matrices

% EMPTY VECTORS
% unfamiliar vs familiar
V_MT_unt_uf = [];
V_SM_unt_uf = [];
V_MT_t_uf = [];
V_SM_t_uf = [];

for ii = 1:6
% MT TRAINED

    MT_unt = load(untrainedMT(ii).name); % read mat data
    M_MT_unt = cell2mat(struct2cell(MT_unt));
    
    V1uf = M_MT_unt(1,2); % unfamiliar vs familiar
    V_MT_unt_uf = [V_MT_unt_uf, V1uf];
    
% SM UNTRAINED

    SM_unt = load(untrainedSM(ii).name); % read mat data
    M_SM_unt = cell2mat(struct2cell(SM_unt));
    
    V2uf = M_SM_unt(1,2); % unfamiliar vs familiar
    V_SM_unt_uf = [V_SM_unt_uf, V2uf];
    
% MT TRAINED

    MT_t = load(trainedMT(ii).name); % read mat data
    M_MT_t = cell2mat(struct2cell(MT_t));
    
    V3uf = M_MT_t(1,2); % unfamiliar vs familiar
    V_MT_t_uf = [V_MT_t_uf, V3uf];

% SM TRAINED

    SM_t = load(trainedSM(ii).name); % read mat data
    M_SM_t = cell2mat(struct2cell(SM_t));
    
    V4uf = M_SM_t(1,2); % unfamiliar vs familiar
    V_SM_t_uf = [V_SM_t_uf, V4uf];
end 

% get rid of zeros and duplicated correlations
% V_MT_unt_uf = V_MT_unt_uf(2,:);
% V_SM_unt_uf = V_SM_unt_uf(2,:);
% V_MT_t_uf = V_MT_t_uf(2,:);
% V_SM_t_uf = V_SM_t_uf(2,:);


% MWW non-parametrical test
mww_MT_UF = mwwtest(V_MT_unt_uf, V_MT_t_uf);
mww_SM_UF = mwwtest(V_SM_unt_uf, V_SM_t_uf);

% -------------------------- bootstrapped results -----

% bootstat = bootstrp(nboot,@bootfun,d)

rng(23);

% unfamiliar vs familiar
boot_V_MT_unt_uf = reshape(bootstrp(1000,@mean,V_MT_unt_uf), 1, []);
boot_V_SM_unt_uf = reshape(bootstrp(1000,@mean,V_SM_unt_uf), 1, []);
boot_V_MT_t_uf = reshape(bootstrp(1000,@mean,V_MT_t_uf), 1, []);
boot_V_SM_t_uf = reshape(bootstrp(1000,@mean,V_SM_t_uf), 1, []);

mwwtest_MT_bootUF = mwwtest(boot_V_MT_unt_uf, boot_V_MT_t_uf);
mwwtest_SM_bootUF = mwwtest(boot_V_SM_unt_uf, boot_V_SM_t_uf);

% ---------------------------- visualisation ---------------

boot_uf = zeros(1000, 4);

boot_uf(:,1) = boot_V_MT_unt_uf;
boot_uf(:,2) = boot_V_SM_unt_uf;
boot_uf(:,3) = boot_V_MT_t_uf;
boot_uf(:,4) = boot_V_SM_t_uf;

% 95% CI limits
% CI = sample mean +- alpha * (SD/sqrt(N))
CIup_MT_unt = mean(boot_uf(:,1)) + (1.96 .* (std(boot_uf(:,1))./sqrt(1000)));
CIlow_MT_unt = mean(boot_uf(:,1)) - (1.96 .* (std(boot_uf(:,1))./sqrt(1000)));

CIup_MT_t = mean(boot_uf(:,3)) + (1.96 .* (std(boot_uf(:,3))./sqrt(1000)));
CIlow_MT_t = mean(boot_uf(:,3)) - (1.96 .* (std(boot_uf(:,3))./sqrt(1000)));

CIup_SM_unt = mean(boot_uf(:,2)) + (1.96 .* (std(boot_uf(:,2))./sqrt(1000)));
CIlow_SM_unt = mean(boot_uf(:,2)) - (1.96 .* (std(boot_uf(:,2))./sqrt(1000)));

CIup_SM_t = mean(boot_uf(:,4)) + (1.96 .* (std(boot_uf(:,4))./sqrt(1000)));
CIlow_SM_t = mean(boot_uf(:,4)) - (1.96 .* (std(boot_uf(:,4))./sqrt(1000)));

% % 4 individual subplots
% figure();
% for i = 1:4
%     subplot(2, 2, i);
%     ksdensity(boot_m(:,i));
%     ylim([0, 25]);
%     xlim([0.35, 0.9]);
%     title(subtitle(i));
% end

% histograms
plt_uf = figure('Position', [158.33,799,1582.67,350]);
sgtitle({'Unfamiliar vs Familiar:','Bootstrap distribution of mean dissimilarity'},'fontname','times', 'fontweight', 'bold');
% 1: MT, 2: SM

subplot(1, 2, 1);
% untrained MT
[f, xi] = ksdensity(boot_uf(:,1));
plot(xi, f, 'color', [0.4940 0.1840 0.5560], 'LineWidth', 1);
hold on
plot([mean(boot_uf(:,1)) mean(boot_uf(:,1))], [0 300], "--", 'color', 'black');
hold on
plot([CIlow_MT_unt CIup_MT_unt],[3 3], 'color', 'red', 'LineWidth', 3);
hold on
% trained MT
[f, xi] = ksdensity(boot_uf(:,3), 'Bandwidth', 0.01);
plot(xi, f, 'color', [0.8500 0.3250 0.0980], 'LineWidth', 1);
hold on
plot([mean(boot_uf(:,3)) mean(boot_uf(:,3))], [0 300], "--", 'color', 'black');
hold on
plot([CIlow_MT_t CIup_MT_t],[3 3], 'color', 'red', 'LineWidth', 3);
hold on
ylim([0, 70]);
xlim([0.2, 0.9]);
title('Motor', 'fontweight', 'bold', 'fontsize', 12);
% ylabel('Untrained', 'Rotation', 0, 'Position', [0.1,30], 'fontweight', 'bold', 'fontsize', 12);
set(gca,'fontname','times');

subplot(1, 2, 2);
% untrained SM
[f, xi] = ksdensity(boot_uf(:,2));
plot(xi, f, 'color', [0.4940 0.1840 0.5560], 'LineWidth', 1);
hold on
plot([mean(boot_uf(:,2)) mean(boot_uf(:,2))], [0 300], "--", 'color', 'black');
hold on
plot([CIlow_SM_unt CIup_SM_unt],[3 3], 'color', 'red', 'LineWidth', 3);
hold on
% trained SM
[f, xi] = ksdensity(boot_uf(:,4),'Bandwidth', 0.01);
plot(xi, f, 'color', [0.8500 0.3250 0.0980], 'LineWidth', 1);
hold on
plot([mean(boot_uf(:,4)) mean(boot_uf(:,4))], [0 300], "--", 'color', 'black');
hold on
plot([CIlow_SM_t CIup_SM_t],[3 3], 'color', 'red', 'LineWidth', 3);
hold on 
ylim([0, 70]); 
xlim([0.2, 0.9]);
title('Somatosensory', 'fontweight', 'bold', 'fontsize', 12);
xlabel('Dissimilarity index', 'Position', [.09, -.5]);
legend('No-training group', '', '', 'Training group');
set(gca,'fontname','times');

saveas(plt_uf, 'X:\data\mvpa\_OUTPUT\RESULTS_plots\plt_uf.png', 'png');