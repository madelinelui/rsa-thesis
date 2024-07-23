% for sanity check: random pairwise combinations
clearvars all;clc;close all

% ---------- load files
[untrainedMT, untrainedSM, trainedMT, trainedSM] = files_by_ROI_TRAIN();

% --------- get matrices

% EMPTY MATRICES
MT_unt_pairwise = zeros(6,6); % Rows(i): participants. % Columns(j): Pairwise combinations.
MT_t_pairwise = zeros(6,6);
SM_unt_pairwise = zeros(6,6);
SM_t_pairwise = zeros(6,6);

% pairwise patterns:
% Brush vs Smoothie, Brush vs Cubie, Brush vs Mug;
% Mug vs Smoothie, Mug vs Cubie, Cubie vs Smoothie

for ii = 1:5
% MT UNTRAINED

    MT_unt = load(untrainedMT(ii).name); % read mat data
    M_MT_unt = cell2mat(struct2cell(MT_unt));

    newOrder = [1 3 2 4];
    
    M_MT_unt = M_MT_unt(newOrder,:);
    M_MT_unt = M_MT_unt(:,newOrder);
    
    % Pairwise comparisons set-up here.
    MT_unt_pairwise(ii, 1) = M_MT_unt(4,1); % brush vs smoothie
    MT_unt_pairwise(ii, 2) = M_MT_unt(3,1); % brush vs cubie
    MT_unt_pairwise(ii, 3) = M_MT_unt(2,1); % brush vs mug
    MT_unt_pairwise(ii, 4) = M_MT_unt(2,4); % mug vs smoothie
    MT_unt_pairwise(ii, 5) = M_MT_unt(2,3); % mug vs cubie
    MT_unt_pairwise(ii, 6) = M_MT_unt(3,4); % cubie vs smoothie

% SM UNTRAINED

    SM_unt = load(untrainedSM(ii).name); % read mat data
    M_SM_unt = cell2mat(struct2cell(SM_unt));
    
    M_SM_unt = M_SM_unt(newOrder,:);
    M_SM_unt = M_SM_unt(:,newOrder);
    
    SM_unt_pairwise(ii, 1) = M_SM_unt(4,1); % brush vs smoothie
    SM_unt_pairwise(ii, 2) = M_SM_unt(3,1); % brush vs cubie
    SM_unt_pairwise(ii, 3) = M_SM_unt(2,1); % brush vs mug
    SM_unt_pairwise(ii, 4) = M_SM_unt(2,4); % mug vs smoothie
    SM_unt_pairwise(ii, 5) = M_SM_unt(2,3); % mug vs cubie
    SM_unt_pairwise(ii, 6) = M_SM_unt(3,4); % cubie vs smoothie
    
% MT TRAINED

    MT_t = load(trainedMT(ii).name); % read mat data
    M_MT_t = cell2mat(struct2cell(MT_t));
    
    M_MT_t = M_MT_t(newOrder,:);
    M_MT_t = M_MT_t(:,newOrder);
    
    % convert matrix to column vector
    MT_t_pairwise(ii, 1) = M_MT_t(4,1); % brush vs smoothie
    MT_t_pairwise(ii, 2) = M_MT_t(3,1); % brush vs cubie
    MT_t_pairwise(ii, 3) = M_MT_t(2,1); % brush vs mug
    MT_t_pairwise(ii, 4) = M_MT_t(2,4); % mug vs smoothie
    MT_t_pairwise(ii, 5) = M_MT_t(2,3); % mug vs cubie
    MT_t_pairwise(ii, 6) = M_MT_t(3,4); % cubie vs smoothie

% SM TRAINED

    SM_t = load(trainedSM(ii).name); % read mat data
    M_SM_t = cell2mat(struct2cell(SM_t));
    
    M_SM_t = M_SM_t(newOrder,:);
    M_SM_t = M_SM_t(:,newOrder);
    
    SM_t_pairwise(ii, 1) = M_SM_t(4,1); % brush vs smoothie
    SM_t_pairwise(ii, 2) = M_SM_t(3,1); % brush vs cubie
    SM_t_pairwise(ii, 3) = M_SM_t(2,1); % brush vs mug
    SM_t_pairwise(ii, 4) = M_SM_t(2,4); % mug vs smoothie
    SM_t_pairwise(ii, 5) = M_SM_t(2,3); % mug vs cubie
    SM_t_pairwise(ii, 6) = M_SM_t(3,4); % cubie vs smoothie

end 

% --------------------------------- correction for outlier
for ii = 1:6
    MT_unt_pairwise(6, ii) = mean(MT_unt_pairwise(1:5, ii));
    SM_unt_pairwise(6, ii) = mean(SM_unt_pairwise(1:5, ii));
    MT_t_pairwise(6, ii) = mean(MT_t_pairwise(1:5, ii));
    SM_t_pairwise(6, ii) = mean(SM_t_pairwise(1:5, ii));
end

% -------------------------- bootstrapped results -----

% bootstat = bootstrp(nboot,@bootfun,d)

rng(23);

boot_MT_unt_pairwise = zeros(1000,6); % Rows(i): Number of bootstrap iterations % Columns(j): Pairwise combinations.
boot_MT_t_pairwise = zeros(1000,6);
boot_SM_unt_pairwise = zeros(1000,6);
boot_SM_t_pairwise = zeros(1000,6);

boot_MT_unt_pairwise = bootstrp(1000, @mean, MT_unt_pairwise);
boot_MT_t_pairwise = bootstrp(1000, @mean, MT_t_pairwise);
boot_SM_unt_pairwise = bootstrp(1000, @mean, SM_unt_pairwise);
boot_SM_t_pairwise = bootstrp(1000, @mean, SM_t_pairwise);

% ----------- test
% brush vs smoothie
unt_mt_bs = reshape(boot_MT_unt_pairwise(:,1), 1, []);
t_mt_bs = reshape(boot_MT_t_pairwise(:,1), 1, []);

unt_sm_bs = reshape(boot_SM_unt_pairwise(:,1), 1, []);
t_sm_bs = reshape(boot_SM_t_pairwise(:,1), 1, []);

% brush vs cubie
unt_mt_bc = reshape(boot_MT_unt_pairwise(:,2), 1, []);
t_mt_bc = reshape(boot_MT_t_pairwise(:,2), 1, []);

unt_sm_bc = reshape(boot_SM_unt_pairwise(:,2), 1, []);
t_sm_bc = reshape(boot_SM_t_pairwise(:,2), 1, []);

% mug vs smoothie
unt_mt_ms = reshape(boot_MT_unt_pairwise(:,4), 1, []);
t_mt_ms = reshape(boot_MT_t_pairwise(:,4), 1, []);

unt_sm_ms = reshape(boot_SM_unt_pairwise(:,4), 1, []);
t_sm_ms = reshape(boot_SM_t_pairwise(:,4), 1, []);

% mug vs cubie
unt_mt_mc = reshape(boot_MT_unt_pairwise(:,5), 1, []);
t_mt_mc = reshape(boot_MT_t_pairwise(:,5), 1, []);

unt_sm_mc = reshape(boot_SM_unt_pairwise(:,5), 1, []);
t_sm_mc = reshape(boot_SM_t_pairwise(:,5), 1, []);

% mww
test_mt_bs = mwwtest(unt_mt_bs, t_mt_bs);
test_sm_bs = mwwtest(unt_sm_bs, t_sm_bs);

test_mt_bc = mwwtest(unt_mt_bc, t_mt_bc);
test_sm_bc = mwwtest(unt_sm_bc, t_sm_bc);

test_mt_ms = mwwtest(unt_mt_ms, t_mt_ms);
test_sm_ms = mwwtest(unt_sm_ms, t_sm_ms);

test_mt_mc = mwwtest(unt_mt_mc, t_mt_mc);
test_sm_mc = mwwtest(unt_sm_mc, t_sm_mc);
% ------------------------- 95% CI


% ------------------------------------- plot

boot_pairwise_afterCorrection = figure('Position', [413.66,760.33,1181.33,350]);
% MT UNTRAINED
subplot(2,2,1);
for j = 1:6
    [f, xi] = ksdensity(boot_MT_unt_pairwise(1:1000,j));
    plot(xi, f);
    xlim([0.2,0.9]);
    ylim([0,68]);
    title('Motor', 'fontweight', 'bold');
    ylabel('Untrained', 'Rotation', 0, 'Position', [0.13,30], 'fontweight', 'bold');
    set(gca,'fontname','times');
    hold on
end
% SM UNTRAINED
subplot(2,2,2);
for j = 1:6
    [f, xi] = ksdensity(boot_SM_unt_pairwise(1:1000,j));
    plot(xi, f);
    xlim([0.2,0.9]);
    ylim([0,68]); set(gca,'fontname','times');
    title('Somatosensory', 'fontweight', 'bold');
    hold on
end
% MT TRAINED
subplot(2,2,3, 'Position');
for j = 1:6
    [f, xi] = ksdensity(boot_MT_t_pairwise(1:1000,j));
    plot(xi, f);
    xlim([0.2,0.9]);
    ylim([0,68]);
    ylabel('Trained', 'Rotation', 0, 'Position', [0.13,30], 'fontweight', 'bold');
    set(gca,'fontname','times');
    hold on
end
% SM TRAINED
subplot(2,2,4);
for j = 1:6
    [f, xi] = ksdensity(boot_SM_t_pairwise(1:1000,j));
    plot(xi, f);
    xlim([0.2,0.9]);
    ylim([0,68]);
    legend('brush vs smoothie', 'brush vs cubie', 'brush vs mug', 'mug vs smoothie', 'mug vs cubie', 'cubie vs smoothie');
    xlabel('Dissimilarity index', 'Position', [.09, -.5]);
    set(gca,'fontname','times');
    hold on
end

% saveas(boot_pairwise_afterCorrection, 'X:\data\mvpa\_OUTPUT\RESULTS_plots\boot_pairwise_afterCorrection.png', 'png');

% bootmww_MT_CS = mwwtest(boot_V_MT_unt, boot_V_MT_t);
% bootmww_SM_CS = mwwtest(boot_V_SM_unt, boot_V_SM_t);

% bootmww_MT_BM = mwwtest(boot_V_MT_unt_bm, boot_V_MT_t_bm);
% bootmww_SM_BM = mwwtest(boot_V_SM_unt_bm, boot_V_SM_t_bm);
% 
% 
% % ---------------------------- visualisation ---------------
% 
% % 95% CI limits
% % CI = sample mean +- alpha x (SD/sqrt(N))
% CIup_MT_unt = mean(boot_cs(:,1)) + (1.96 .* (std(boot_cs(:,1))./sqrt(1000)));
% CIlow_MT_unt = mean(boot_cs(:,1)) - (1.96 .* (std(boot_cs(:,1))./sqrt(1000)));
% 
% CIup_MT_t = mean(boot_cs(:,3)) + (1.96 .* (std(boot_cs(:,3))./sqrt(1000)));
% CIlow_MT_t = mean(boot_cs(:,3)) - (1.96 .* (std(boot_cs(:,3))./sqrt(1000)));
% 
% CIup_SM_unt = mean(boot_cs(:,2)) + (1.96 .* (std(boot_cs(:,2))./sqrt(1000)));
% CIlow_SM_unt = mean(boot_cs(:,2)) - (1.96 .* (std(boot_cs(:,2))./sqrt(1000)));
% 
% CIup_SM_t = mean(boot_cs(:,4)) + (1.96 .* (std(boot_cs(:,4))./sqrt(1000)));
% CIlow_SM_t = mean(boot_cs(:,4)) - (1.96 .* (std(boot_cs(:,4))./sqrt(1000)));
% 
% % BRUSH VS MUG
% CIup_MT_BMU = mean(boot_bm(:,1)) + (1.96 .* (std(boot_bm(:,1))./sqrt(1000)));
% CIlow_MT_BMU = mean(boot_bm(:,1)) - (1.96 .* (std(boot_bm(:,1))./sqrt(1000)));
% 
% CIup_MT_BMT = mean(boot_bm(:,3)) + (1.96 .* (std(boot_bm(:,3))./sqrt(1000)));
% CIlow_MT_BMT = mean(boot_bm(:,3)) - (1.96 .* (std(boot_bm(:,3))./sqrt(1000)));
% 
% CIup_SM_BMU = mean(boot_bm(:,2)) + (1.96 .* (std(boot_bm(:,2))./sqrt(1000)));
% CIlow_SM_BMU = mean(boot_bm(:,2)) - (1.96 .* (std(boot_bm(:,2))./sqrt(1000)));
% 
% CIup_SM_BMT = mean(boot_bm(:,4)) + (1.96 .* (std(boot_bm(:,4))./sqrt(1000)));
% CIlow_SM_BMT = mean(boot_bm(:,4)) - (1.96 .* (std(boot_bm(:,4))./sqrt(1000)));