% MWW TEST AND BOOTSTRAPPED RESULTS + VISUALISATIONS
clearvars all;clc;close all

% ---------- load files
[untrainedMT, untrainedSM, trainedMT, trainedSM] = files_by_ROI_TRAIN();

% --------- get matrices

% EMPTY VECTORS
% cubie vs smoothie
V_MT_unt = [];
V_SM_unt = [];
V_MT_t = [];
V_SM_t = [];

% brush vs mug
V_MT_unt_bm = [];
V_SM_unt_bm = [];
V_MT_t_bm = [];
V_SM_t_bm = [];

% leave p6 out
for ii = 1:5
% MT UNTRAINED

    MT_unt = load(untrainedMT(ii).name); % read mat data
    M_MT_unt = cell2mat(struct2cell(MT_unt));

    newOrder = [1 3 2 4];
    
    M_MT_unt = M_MT_unt(newOrder,:);
    M_MT_unt = M_MT_unt(:,newOrder);
    
    % convert matrix to column vector
    V1 = reshape(M_MT_unt(3:4,3:4),[],1); % cubie vs smoothie
    V_MT_unt = [V_MT_unt, V1];

    V1bm = reshape(M_MT_unt(1:2,1:2),[],1); % brush vs mug
    V_MT_unt_bm = [V_MT_unt_bm, V1bm];
    
    
% SM UNTRAINED

    SM_unt = load(untrainedSM(ii).name); % read mat data
    M_SM_unt = cell2mat(struct2cell(SM_unt));
    
    M_SM_unt = M_SM_unt(newOrder,:);
    M_SM_unt = M_SM_unt(:,newOrder);
    
    % convert matrix to column vector
    V2 = reshape(M_SM_unt(3:4,3:4),[],1);
    V_SM_unt = [V_SM_unt, V2];

    V2bm = reshape(M_SM_unt(1:2,1:2),[],1); % brush vs mug
    V_SM_unt_bm = [V_SM_unt_bm, V2bm];
    
% MT TRAINED

    MT_t = load(trainedMT(ii).name); % read mat data
    M_MT_t = cell2mat(struct2cell(MT_t));
    
    M_MT_t = M_MT_t(newOrder,:);
    M_MT_t = M_MT_t(:,newOrder);
    
    % convert matrix to column vector
    V3 = reshape(M_MT_t(3:4,3:4),[],1);
    V_MT_t = [V_MT_t, V3];

    V3bm = reshape(M_MT_t(1:2,1:2),[],1); % brush vs mug
    V_MT_t_bm = [V_MT_t_bm, V3bm];


% SM TRAINED

    SM_t = load(trainedSM(ii).name); % read mat data
    M_SM_t = cell2mat(struct2cell(SM_t));
    
    M_SM_t = M_SM_t(newOrder,:);
    M_SM_t = M_SM_t(:,newOrder);
    
    % convert matrix to column vector
    V4 = reshape(M_SM_t(3:4,3:4),[],1);
    V_SM_t = [V_SM_t, V4];
    
    V4bm = reshape(M_SM_t(1:2,1:2),[],1); % brush vs mug
    V_SM_t_bm = [V_SM_t_bm, V4bm];

end 

% get rid of zeros and duplicated correlations
V_MT_unt = V_MT_unt(2,:);
V_SM_unt = V_SM_unt(2,:);
V_MT_t = V_MT_t(2,:);
V_SM_t = V_SM_t(2,:);

V_MT_unt_bm = V_MT_unt_bm(2,:);
V_SM_unt_bm = V_SM_unt_bm(2,:);
V_MT_t_bm = V_MT_t_bm(2,:);
V_SM_t_bm = V_SM_t_bm(2,:);

% --------------------------------- correction for outlier

% method: replace last participant with a mean of the rest
V_MT_unt(:,6) = mean(V_MT_unt);
V_SM_unt(:,6) = mean(V_SM_unt);
V_MT_t(:,6) = mean(V_MT_t);
V_SM_t(:,6) = mean(V_SM_t);

% brush vs mug
V_MT_unt_bm(:,6) = mean(V_MT_unt_bm);
V_SM_unt_bm(:,6) = mean(V_SM_unt_bm);
V_MT_t_bm(:,6) = mean(V_MT_t_bm);
V_SM_t_bm(:,6) = mean(V_SM_t_bm);


% MWW non-parametrical test CUBIE VS SMOOTHIE
mww_MT_CS = mwwtest(V_MT_unt, V_MT_t);
mww_SM_CS = mwwtest(V_SM_unt, V_SM_t);

% MWW BRUSH VS MUG
mww_MT_BM = mwwtest(V_MT_unt_bm, V_MT_t_bm);
mww_SM_BM = mwwtest(V_SM_unt_bm, V_SM_t_bm);

% -------------------------- bootstrapped results -----

% bootstat = bootstrp(nboot,@bootfun,d)

rng(23);

boot_V_MT_unt = reshape(bootstrp(1000,@mean,V_MT_unt), 1, []);
boot_V_SM_unt = reshape(bootstrp(1000,@mean,V_SM_unt), 1, []);
boot_V_MT_t = reshape(bootstrp(1000,@mean,V_MT_t), 1, []);
boot_V_SM_t = reshape(bootstrp(1000,@mean,V_SM_t), 1, []);

bootmww_MT_CS = mwwtest(boot_V_MT_unt, boot_V_MT_t);
bootmww_SM_CS = mwwtest(boot_V_SM_unt, boot_V_SM_t);

% brush vs mug
boot_V_MT_unt_bm = reshape(bootstrp(1000,@mean,V_MT_unt_bm), 1, []);
boot_V_SM_unt_bm = reshape(bootstrp(1000,@mean,V_SM_unt_bm), 1, []);
boot_V_MT_t_bm = reshape(bootstrp(1000,@mean,V_MT_t_bm), 1, []);
boot_V_SM_t_bm = reshape(bootstrp(1000,@mean,V_SM_t_bm), 1, []);

bootmww_MT_BM = mwwtest(boot_V_MT_unt_bm, boot_V_MT_t_bm);
bootmww_SM_BM = mwwtest(boot_V_SM_unt_bm, boot_V_SM_t_bm);

% bm vs cs

mwwtest(boot_V_MT_unt_bm, boot_V_MT_unt);
mwwtest(boot_V_SM_unt_bm, boot_V_SM_unt);

mwwtest(boot_V_MT_t_bm, boot_V_MT_t);
mwwtest(boot_V_SM_t_bm, boot_V_SM_t);


% ---------------------------- visualisation ---------------

% boot_mat_MT_unt = reshape(boot_V_MT_unt, 50, 50);
% heatmap(boot_mat_MT_unt, 'Colormap', hot);
% caxis([0.4, 0.9]);
boot_cs = zeros(1000,4);
boot_bm = zeros(1000,4);
% boot_uf

boot_cs(:,1) = boot_V_MT_unt;
boot_cs(:,2) = boot_V_SM_unt;
boot_cs(:,3) = boot_V_MT_t;
boot_cs(:,4) = boot_V_SM_t;

boot_bm(:,1) = boot_V_MT_unt_bm;
boot_bm(:,2) = boot_V_SM_unt_bm;
boot_bm(:,3) = boot_V_MT_t_bm;
boot_bm(:,4) = boot_V_SM_t_bm;

% 95% CI limits
% CI = sample mean +- alpha x (SD/sqrt(N))
CIup_MT_unt = mean(boot_cs(:,1)) + (1.96 .* (std(boot_cs(:,1))./sqrt(1000)));
CIlow_MT_unt = mean(boot_cs(:,1)) - (1.96 .* (std(boot_cs(:,1))./sqrt(1000)));

CIup_MT_t = mean(boot_cs(:,3)) + (1.96 .* (std(boot_cs(:,3))./sqrt(1000)));
CIlow_MT_t = mean(boot_cs(:,3)) - (1.96 .* (std(boot_cs(:,3))./sqrt(1000)));

CIup_SM_unt = mean(boot_cs(:,2)) + (1.96 .* (std(boot_cs(:,2))./sqrt(1000)));
CIlow_SM_unt = mean(boot_cs(:,2)) - (1.96 .* (std(boot_cs(:,2))./sqrt(1000)));

CIup_SM_t = mean(boot_cs(:,4)) + (1.96 .* (std(boot_cs(:,4))./sqrt(1000)));
CIlow_SM_t = mean(boot_cs(:,4)) - (1.96 .* (std(boot_cs(:,4))./sqrt(1000)));

% BRUSH VS MUG
CIup_MT_BMU = mean(boot_bm(:,1)) + (1.96 .* (std(boot_bm(:,1))./sqrt(1000)));
CIlow_MT_BMU = mean(boot_bm(:,1)) - (1.96 .* (std(boot_bm(:,1))./sqrt(1000)));

CIup_MT_BMT = mean(boot_bm(:,3)) + (1.96 .* (std(boot_bm(:,3))./sqrt(1000)));
CIlow_MT_BMT = mean(boot_bm(:,3)) - (1.96 .* (std(boot_bm(:,3))./sqrt(1000)));

CIup_SM_BMU = mean(boot_bm(:,2)) + (1.96 .* (std(boot_bm(:,2))./sqrt(1000)));
CIlow_SM_BMU = mean(boot_bm(:,2)) - (1.96 .* (std(boot_bm(:,2))./sqrt(1000)));

CIup_SM_BMT = mean(boot_bm(:,4)) + (1.96 .* (std(boot_bm(:,4))./sqrt(1000)));
CIlow_SM_BMT = mean(boot_bm(:,4)) - (1.96 .* (std(boot_bm(:,4))./sqrt(1000)));

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
plt_cs = figure('Position', [158.33,799,1582.67,350]);
sgtitle({'Cubie vs Smoothie:','Bootstrap distribution of mean dissimilarity'},'fontname','times', 'fontweight', 'bold');
% 1: MT , 2: SM
subplot(1, 2, 1);
% MT untrained
[f, xi] = ksdensity(boot_cs(:,1));
plot(xi, f, 'color', [0.4940 0.1840 0.5560], 'LineWidth', 1);
hold on
plot([mean(boot_cs(:,1)) mean(boot_cs(:,1))], [0 300], "--", 'color', 'black');
hold on
plot([CIlow_MT_unt CIup_MT_unt],[3 3], 'color', 'red', 'LineWidth', 3);
hold on
% trained MT
[f, xi] = ksdensity(boot_cs(:,3));
plot(xi, f, 'color', [0.8500 0.3250 0.0980], 'LineWidth', 1);
hold on
plot([mean(boot_cs(:,3)) mean(boot_cs(:,3))], [0 300], "--", 'color', 'black');
hold on
plot([CIlow_MT_t CIup_MT_t],[3 3], 'color', 'red', 'LineWidth', 3);
% title('Motor', 'fontweight', 'bold', 'fontsize', 12);
% ylabel('Untrained', 'Rotation', 0, 'Position', [0.1,30], 'fontweight', 'bold', 'fontsize', 12);
ylim([0, 65]);
xlim([0.2, 0.9]);
set(gca,'fontname','times');

subplot(1, 2, 2);
% SM untrained
[f, xi] = ksdensity(boot_cs(:,2));
plot(xi, f, 'color', [0.4940 0.1840 0.5560], 'LineWidth', 1);
hold on
plot([mean(boot_cs(:,2)) mean(boot_cs(:,2))], [0 300], "--", 'color', 'black');
hold on
plot([CIlow_SM_unt CIup_SM_unt],[3 3], 'color', 'red', 'LineWidth', 3);
hold on
% SM trained
[f, xi] = ksdensity(boot_cs(:,4));
plot(xi, f, 'color', [0.8500 0.3250 0.0980], 'LineWidth', 1);
hold on
plot([mean(boot_cs(:,4)) mean(boot_cs(:,4))], [0 300], "--", 'color', 'black');
hold on
plot([CIlow_SM_t CIup_SM_t],[3 3], 'color', 'red', 'LineWidth', 3);
% title('Somatosensory', 'fontweight', 'bold', 'fontsize', 12);
xlabel('Dissimilarity index', 'Position', [.09, -.5]);
legend('No-training group','','','Training group');
ylim([0, 65]);
xlim([0.2, 0.9]);
set(gca,'fontname','times');


% -- brush vs mug
plt_bm = figure('Position', [158.33,799,1582.67,350]);
sgtitle({'Brush vs Mug:','Bootstrap distribution of mean dissimilarity'},'fontname','times', 'fontweight', 'bold');
% 1: MT, 2: SM
subplot(1, 2, 1);
% MT untrained
[f, xi] = ksdensity(boot_bm(:,1));
plot(xi, f, 'color', [0.4940 0.1840 0.5560], 'LineWidth', 1);
hold on
plot([mean(boot_bm(:,1)) mean(boot_bm(:,1))], [0 300], "--", 'color', 'black');
hold on
plot([CIlow_MT_BMU CIup_MT_BMU],[3 3], 'color', 'red', 'LineWidth', 3);
hold on
% MT trained
[f, xi] = ksdensity(boot_bm(:,3));
plot(xi, f, 'color', [0.8500 0.3250 0.0980], 'LineWidth', 1);
hold on
plot([mean(boot_bm(:,3)) mean(boot_bm(:,3))], [0 300], "--", 'color', 'black');
hold on
plot([CIlow_MT_BMT CIup_MT_BMT],[3 3], 'color', 'red', 'LineWidth', 3);
title('Motor', 'fontweight', 'bold', 'fontsize', 12);
ylim([0, 65]);
xlim([0.2, 0.9]);
set(gca,'fontname','times');

subplot(1, 2, 2);
[f, xi] = ksdensity(boot_bm(:,2));
plot(xi, f, 'color', [0.4940 0.1840 0.5560], 'LineWidth', 1);
hold on
plot([mean(boot_bm(:,2)) mean(boot_bm(:,2))], [0 300], "--", 'color', 'black');
hold on
plot([CIlow_SM_BMU CIup_SM_BMU],[3 3], 'color', 'red', 'LineWidth', 3);
hold on
% SM Trained
[f, xi] = ksdensity(boot_bm(:,4));
plot(xi, f, 'color', [0.8500 0.3250 0.0980], 'LineWidth', 1);
hold on
plot([mean(boot_bm(:,4)) mean(boot_bm(:,4))], [0 300], "--", 'color', 'black');
hold on
plot([CIlow_SM_BMT CIup_SM_BMT],[3 3], 'color', 'red', 'LineWidth', 3);
title('Somatosensory', 'fontweight', 'bold', 'fontsize', 12);
ylim([0, 65]);
xlim([0.2, 0.9]);
% xlabel('Dissimilarity index', 'Position', [.09, -.5]);
set(gca,'fontname','times');

% SAVE BOOTSTRAP VISUALISATION
saveas(plt_cs, 'X:\data\mvpa\_OUTPUT\RESULTS_plots\plt_cs.png', 'png');
saveas(plt_bm, 'X:\data\mvpa\_OUTPUT\RESULTS_plots\plt_bm.png', 'png');
