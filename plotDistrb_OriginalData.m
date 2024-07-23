% plot distribution of 1-r after outlier correction
clearvars all;clc;close all

% ---------- load files
[untrainedMT, untrainedSM, trainedMT, trainedSM] = files_by_ROI_TRAIN();

% --------- get matrices

% EMPTY VECTORS
% cubie vs smoothie
V_MT_unt_cs = [];
V_SM_unt_cs = [];
V_MT_t_cs = [];
V_SM_t_cs = [];

% brush vs mug
V_MT_unt_bm = [];
V_SM_unt_bm = [];
V_MT_t_bm = [];
V_SM_t_bm = [];

% % unfamiliar vs familiar
% V_MT_unt_uf = [];
% V_SM_unt_uf = [];
% V_MT_t_uf = [];
% V_SM_t_uf = [];

% sum for P1:5
% sum_MT_unt_bm = zeros(4,1);
% sum_SM_unt_bm = zeros(4,1);
% sum_MT_t_bm = zeros(4,1);
% sum_SM_t_bm = zeros(4,1);
% 
% sum_MT_unt_cs = zeros(4,1);
% sum_SM_unt_cs = zeros(4,1);
% sum_MT_t_cs = zeros(4,1);
% sum_SM_t_cs = zeros(4,1);

for ii = 1:6
% MT UNTRAINED

    MT_unt = load(untrainedMT(ii).name); % read mat data
    M_MT_unt = cell2mat(struct2cell(MT_unt));

    newOrder = [1 3 2 4];
    
    M_MT_unt = M_MT_unt(newOrder,:);
    M_MT_unt = M_MT_unt(:,newOrder);
    
    % convert matrix to row vector
    V1 = reshape(M_MT_unt(3:4,3:4),[],1); % cubie vs smoothie
    V_MT_unt_cs = [V_MT_unt_cs, V1];

    
    V1bm = reshape(M_MT_unt(1:2,1:2),[],1); % brush vs mug
    V_MT_unt_bm = [V_MT_unt_bm, V1bm];

    
%     V1uf = reshape(M_MT_unt(3:4,1:2),[],1); % unfamiliar vs familiar
%     V_MT_unt_uf = [V_MT_unt_uf, V1uf];
    
% SM UNTRAINED

    SM_unt = load(untrainedSM(ii).name); % read mat data
    M_SM_unt = cell2mat(struct2cell(SM_unt));
    
    M_SM_unt = M_SM_unt(newOrder,:);
    M_SM_unt = M_SM_unt(:,newOrder);
    
    % convert matrix to row vector
    V2 = reshape(M_SM_unt(3:4,3:4),[],1); % cubie vs smoothie
    V_SM_unt_cs = [V_SM_unt_cs, V2];

    
    V2bm = reshape(M_SM_unt(1:2,1:2),[],1); % brush vs mug
    V_SM_unt_bm = [V_SM_unt_bm, V2bm];

    
%     V2uf = reshape(M_SM_unt(3:4,1:2),[],1); % unfamiliar vs familiar
%     V_SM_unt_uf = [V_SM_unt_uf, V2uf];
% MT TRAINED

    MT_t = load(trainedMT(ii).name); % read mat data
    M_MT_t = cell2mat(struct2cell(MT_t));
    
    M_MT_t = M_MT_t(newOrder,:);
    M_MT_t = M_MT_t(:,newOrder);
    
    % convert matrix to row vector
    V3 = reshape(M_MT_t(3:4,3:4),[],1);
    V_MT_t_cs = [V_MT_t_cs, V3];
    
    V3bm = reshape(M_MT_t(1:2,1:2),[],1); % brush vs mug
    V_MT_t_bm = [V_MT_t_bm, V3bm];

    
%     V3uf = reshape(M_MT_t(3:4,1:2),[],1); % unfamiliar vs familiar
%     V_MT_t_uf = [V_MT_t_uf, V3uf];

% SM TRAINED

    SM_t = load(trainedSM(ii).name); % read mat data
    M_SM_t = cell2mat(struct2cell(SM_t));
    
    M_SM_t = M_SM_t(newOrder,:);
    M_SM_t = M_SM_t(:,newOrder);
    
    % convert matrix to row vector
    V4 = reshape(M_SM_t(3:4,3:4),[],1);
    V_SM_t_cs = [V_SM_t_cs, V4];

    
    V4bm = reshape(M_SM_t(1:2,1:2),[],1); % brush vs mug
    V_SM_t_bm = [V_SM_t_bm, V4bm];

    
%     V4uf = reshape(M_MT_t(3:4,1:2),[],1); % unfamiliar vs familiar
%     V_SM_t_uf = [V_SM_t_uf, V4uf];
end 


% get rid of zeros and duplicated correlations
V_MT_unt_cs = V_MT_unt_cs(2,:);
V_SM_unt_cs = V_SM_unt_cs(2,:);
V_MT_t_cs = V_MT_t_cs(2,:);
V_SM_t_cs = V_SM_t_cs(2,:);

V_MT_unt_bm = V_MT_unt_bm(2,:);
V_SM_unt_bm = V_SM_unt_bm(2,:);
V_MT_t_bm = V_MT_t_bm(2,:);
V_SM_t_bm = V_SM_t_bm(2,:);

% ----------------------- CORRECTIONS 
sum_MT_unt_bm = sum(V_MT_unt_bm(:,(1:5)), 2);
sum_SM_unt_bm = sum(V_SM_unt_bm(:,(1:5)), 2);
sum_MT_t_bm = sum(V_MT_t_bm(:,(1:5)), 2);
sum_SM_t_bm = sum(V_SM_t_bm(:,(1:5)), 2);

sum_MT_unt_cs = sum(V_MT_unt_cs(:,(1:5)), 2);
sum_SM_unt_cs = sum(V_SM_unt_cs(:,(1:5)), 2);
sum_MT_t_cs = sum(V_MT_t_cs(:,(1:5)), 2);
sum_SM_t_cs = sum(V_SM_t_cs(:,(1:5)), 2);

V_MT_unt_cs(:,6) = sum_MT_unt_cs / 5;
V_SM_unt_cs(:,6) = sum_SM_unt_cs / 5;
V_MT_t_cs(:,6) = sum_MT_t_cs / 5;
V_SM_t_cs(:,6) = sum_SM_t_cs / 5;

V_MT_unt_bm(:,6) = sum_MT_unt_bm / 5;
V_SM_unt_bm(:,6) = sum_SM_unt_bm / 5;
V_MT_t_bm(:,6) = sum_MT_t_bm / 5;
V_SM_t_bm(:,6) = sum_SM_t_bm / 5;

% -----------------------------------------------

% test
mwwtest(V_MT_unt_bm, V_MT_unt_cs);
mwwtest(V_SM_unt_bm, V_SM_unt_cs);

% trained
mwwtest(V_MT_t_bm, V_MT_t_cs);
mwwtest(V_SM_t_bm, V_SM_t_cs);

MT_dissm = zeros(6,4);
SM_dissm = zeros(6,4);

MT_dissm(:,1) = V_MT_unt_bm;
MT_dissm(:,2) = V_MT_unt_cs;
MT_dissm(:,3) = V_MT_t_bm;
MT_dissm(:,4) = V_MT_t_cs;

SM_dissm(:,1) = V_SM_unt_bm;
SM_dissm(:,2) = V_SM_unt_cs;
SM_dissm(:,3) = V_SM_t_bm;
SM_dissm(:,4) = V_SM_t_cs;

% --------------------------------- DISTRIBUTION
x = categorical({'B vs M_U','C vs S_U','B vs M_T','C vs S_T'},{'B vs M_U','C vs S_U','B vs M_T','C vs S_T'});
colour = zeros(4,3);
colour(1,:) = [(72/255) (201/255) (176/255)];
colour(2,:) = [(231/255), (76/255), (60/255)];
colour(3,:) = [(72/255) (201/255) (176/255)];
colour(4,:) = [(231/255), (76/255), (60/255)];

% CI 95% 
CIup_MT_BMU = mean(MT_dissm(:,1)) + (1.96 .* (std(MT_dissm(:,1))./sqrt(6)));
CIlow_MT_BMU = mean(MT_dissm(:,1)) - (1.96 .* (std(MT_dissm(:,1))./sqrt(6)));

CIup_MT_BMT = mean(MT_dissm(:,3)) + (1.96 .* (std(MT_dissm(:,3))./sqrt(6)));
CIlow_MT_BMT = mean(MT_dissm(:,3)) - (1.96 .* (std(MT_dissm(:,3))./sqrt(6)));

CIup_MT_CSU = mean(MT_dissm(:,2)) + (1.96 .* (std(MT_dissm(:,2))./sqrt(6)));
CIlow_MT_CSU = mean(MT_dissm(:,2)) - (1.96 .* (std(MT_dissm(:,2))./sqrt(6)));

CIup_MT_CST = mean(MT_dissm(:,4)) + (1.96 .* (std(MT_dissm(:,4))./sqrt(6)));
CIlow_MT_CST = mean(MT_dissm(:,4)) - (1.96 .* (std(MT_dissm(:,4))./sqrt(6)));

% --- SM

CIup_SM_BMU = mean(SM_dissm(:,1)) + (1.96 .* (std(SM_dissm(:,1))./sqrt(6)));
CIlow_SM_BMU = mean(SM_dissm(:,1)) - (1.96 .* (std(SM_dissm(:,1))./sqrt(6)));

CIup_SM_BMT = mean(SM_dissm(:,3)) + (1.96 .* (std(SM_dissm(:,3))./sqrt(6)));
CIlow_SM_BMT = mean(SM_dissm(:,3)) - (1.96 .* (std(SM_dissm(:,3))./sqrt(6)));

CIup_SM_CSU = mean(SM_dissm(:,2)) + (1.96 .* (std(SM_dissm(:,2))./sqrt(6)));
CIlow_SM_CSU = mean(SM_dissm(:,2)) - (1.96 .* (std(SM_dissm(:,2))./sqrt(6)));

CIup_SM_CST = mean(SM_dissm(:,4)) + (1.96 .* (std(SM_dissm(:,4))./sqrt(6)));
CIlow_SM_CST = mean(SM_dissm(:,4)) - (1.96 .* (std(SM_dissm(:,4))./sqrt(6)));


% ---------------------------------- PLOT


pltD_MT = figure('Position', [747.66,398.33,511.33,419.99]);
% BM T
scatter(MT_dissm(:,3), x(3), 26, 's', 'MarkerFaceColor', colour(3,:), 'MarkerFaceAlpha', 0.8, 'MarkerEdgeColor', [.32,.32,.32], 'LineWidth', .85);
xlim([0.3, 0.7]);
hold on
plot([mean(MT_dissm(:,3)) mean(MT_dissm(:,3))],[2.88 3.12], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
hold on
plot([CIlow_MT_BMT CIlow_MT_BMT],[2.85 3.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIup_MT_BMT CIup_MT_BMT],[2.85 3.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIlow_MT_BMT CIup_MT_BMT],[3 3], 'LineWidth', 1, 'Color', [.32,.32,.32]); 

% CS T
scatter(MT_dissm(:,4), x(4), 26, 's', 'MarkerFaceColor', colour(4,:), 'MarkerFaceAlpha', 0.8, 'MarkerEdgeColor', [.32,.32,.32], 'LineWidth', .85);
xlim([0.3, 0.7]);
hold on
plot([mean(MT_dissm(:,4)) mean(MT_dissm(:,4))],[3.88 4.12], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
hold on
plot([CIlow_MT_CST CIlow_MT_CST],[3.85 4.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIup_MT_CST CIup_MT_CST],[3.85 4.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIlow_MT_CST CIup_MT_CST],[4 4], 'LineWidth', 1, 'Color', [.32,.32,.32]); 

% BM U
scatter(MT_dissm(:,1), x(1), 23, 'MarkerFaceColor', colour(1,:), 'MarkerFaceAlpha', 0.8, 'MarkerEdgeColor', [.32,.32,.32], 'LineWidth', .85);
xlim([0.3, 0.7]);
hold on
plot([mean(MT_dissm(:,1)) mean(MT_dissm(:,1))],[.88 1.12], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
hold on
plot([CIlow_MT_BMU CIlow_MT_BMU],[.85 1.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIup_MT_BMU CIup_MT_BMU],[.85 1.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIlow_MT_BMU CIup_MT_BMU],[1 1], 'LineWidth', 1, 'Color', [.32,.32,.32]); 

% CS U
scatter(MT_dissm(:,2), x(2), 23, 'MarkerFaceColor', colour(2,:), 'MarkerFaceAlpha', 0.8, 'MarkerEdgeColor', [.32,.32,.32], 'LineWidth', .85);
xlim([0.3, 0.7]);
hold on
plot([mean(MT_dissm(:,2)) mean(MT_dissm(:,2))],[1.88 2.12], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
hold on
plot([CIlow_MT_CSU CIlow_MT_CSU],[1.85 2.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIup_MT_CSU CIup_MT_CSU],[1.85 2.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIlow_MT_CSU CIup_MT_CSU],[2 2], 'LineWidth', 1, 'Color', [.32,.32,.32]); 

set (gca,'YDir','reverse', 'fontname','times');
xlabel('Dissimilarity index');
hold off

% --- SM
pltD_SM = figure('Position', [747.66,398.33,511.33,419.99]);
scatter(SM_dissm(:,3), x(3), 26, 's', 'MarkerFaceColor', colour(3,:), 'MarkerFaceAlpha', 0.8, 'MarkerEdgeColor', [.32,.32,.32], 'LineWidth', .85);
xlim([0.3, 0.7]);
hold on
plot([mean(SM_dissm(:,3)) mean(SM_dissm(:,3))],[2.88 3.12], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
hold on
plot([CIlow_SM_BMT CIlow_SM_BMT],[2.85 3.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIup_SM_BMT CIup_SM_BMT],[2.85 3.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIlow_SM_BMT CIup_SM_BMT],[3 3], 'LineWidth', 1, 'Color', [.32,.32,.32]); 

scatter(SM_dissm(:,4), x(4), 26, 's', 'MarkerFaceColor', colour(4,:), 'MarkerFaceAlpha', 0.8, 'MarkerEdgeColor', [.32,.32,.32], 'LineWidth', .85);
xlim([0.3, 0.7]);
hold on
plot([mean(SM_dissm(:,4)) mean(SM_dissm(:,4))],[3.88 4.12], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
hold on
plot([CIlow_SM_CST CIlow_SM_CST],[3.85 4.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIup_SM_CST CIup_SM_CST],[3.85 4.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIlow_SM_CST CIup_SM_CST],[4 4], 'LineWidth', 1, 'Color', [.32,.32,.32]); 

% BM U
scatter(SM_dissm(:,1), x(1), 23, 'MarkerFaceColor', colour(1,:), 'MarkerFaceAlpha', 0.8, 'MarkerEdgeColor', [.32,.32,.32], 'LineWidth', .85);
xlim([0.3, 0.7]);
hold on
plot([mean(SM_dissm(:,1)) mean(SM_dissm(:,1))],[.88 1.12], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
hold on
plot([CIlow_SM_BMU CIlow_SM_BMU],[.85 1.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIup_SM_BMU CIup_SM_BMU],[.85 1.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIlow_SM_BMU CIup_SM_BMU],[1 1], 'LineWidth', 1, 'Color', [.32,.32,.32]); 

% CS U
scatter(SM_dissm(:,2), x(2), 23, 'MarkerFaceColor', colour(2,:), 'MarkerFaceAlpha', 0.8, 'MarkerEdgeColor', [.32,.32,.32], 'LineWidth', .85);
xlim([0.3, 0.7]);
hold on
plot([mean(SM_dissm(:,2)) mean(SM_dissm(:,2))],[1.88 2.12], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
hold on
plot([CIlow_SM_CSU CIlow_SM_CSU],[1.85 2.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIup_SM_CSU CIup_SM_CSU],[1.85 2.15], 'LineWidth', 1, 'Color', [.32,.32,.32]); 
plot([CIlow_SM_CSU CIup_SM_CSU],[2 2], 'LineWidth', 1, 'Color', [.32,.32,.32]); 

set (gca,'YDir','reverse', 'fontname','times');
xlabel('Dissimilarity index');
hold off

saveas(pltD_MT, 'X:\data\mvpa\_OUTPUT\RESULTS_plots\pltD_MT_corrected.png', 'png');
saveas(pltD_SM, 'X:\data\mvpa\_OUTPUT\RESULTS_plots\pltD_SM_corrected.png', 'png');
