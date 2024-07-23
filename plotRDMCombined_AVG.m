function [h] = plotRDMCombined_AVG()

dirName = '../../_OUTPUT/RDM/';

% -------------------------------------------- CREATE AVERAGED MATRICES

% ----- load files

[untrainedMT, untrainedSM, trainedMT, trainedSM] = files_by_ROI_TRAIN();

sumMat_MT_unt = zeros(2);
sumMat_SM_unt = zeros(2);
sumMat_MT_t = zeros(2);
sumMat_SM_t = zeros(2);

for ii = 1:6
% MT UNTRAINED
    S_MT_unt = load(untrainedMT(ii).name); % read mat data
    M_MT_unt = cell2mat(struct2cell(S_MT_unt));
    
    sumMat_MT_unt = sumMat_MT_unt + M_MT_unt;
    
% SM UNTRAINED

    S_SM_unt = load(untrainedSM(ii).name); % read mat data
    M_SM_unt = cell2mat(struct2cell(S_SM_unt));

    sumMat_SM_unt = sumMat_SM_unt + M_SM_unt;

% MT TRAINED

    S_MT_t = load(trainedMT(ii).name); % read mat data
    M_MT_t = cell2mat(struct2cell(S_MT_t));
    
    sumMat_MT_t = sumMat_MT_t + M_MT_t;

% SM TRAINED

    S_SM_t = load(trainedSM(ii).name); % read mat data
    M_SM_t = cell2mat(struct2cell(S_SM_t));
    
    sumMat_SM_t = sumMat_SM_t + M_SM_t;
    
end 

meanMat_MT_unt = sumMat_MT_unt / 6;
meanMat_SM_unt = sumMat_SM_unt / 6;
meanMat_MT_t = sumMat_MT_t / 6;
meanMat_SM_t = sumMat_SM_t / 6;

% % ---------------------------------------- P6 CORRECTION
% 
% meanMat_MT_unt = (sumMat_MT_unt + meanMat_MT_unt) / 6;
% meanMat_SM_unt = (sumMat_SM_unt + meanMat_SM_unt) / 6;
% meanMat_MT_t = (sumMat_MT_t + meanMat_MT_t) / 6;
% meanMat_SM_t = (sumMat_SM_t + meanMat_SM_t) / 6;

% --------------------------------------------- RDM

figure('Position', [305,413.66,1181.33,803.99]);
sgtitle('Average dissimilarity across participants','fontname','times', 'fontweight', 'bold');
set(0,'DefaultAxesTitleFontWeight','normal');

% MT_unt
subplot(2,2,1);

xtick = ["Familiar", "Unfamiliar"];
xtickstr = string(xtick);

h3 = heatmap(meanMat_MT_unt, 'Colormap', hot);

h3 = gca;

caxis([0, 0.6]);

h3.XDisplayLabels = xtickstr;
h3.YDisplayLabels = xtickstr;

title('Untrained MT');

set(gca,'fontname','times');

% SM_unt
subplot(2,2,2);

xtickstr = string(xtick);

h4 = heatmap(meanMat_SM_unt, 'Colormap', hot);

h4 = gca;

caxis([0, 0.6]);

h4.XDisplayLabels = xtickstr;
h4.YDisplayLabels = xtickstr;

title('Untrained SM');

set(gca,'fontname','times');

% MT_t
subplot(2,2,3);

xtickstr = string(xtick);

h = heatmap(meanMat_MT_t, 'Colormap', hot);

h = gca;

caxis([0, 0.6]);

h.XDisplayLabels = xtickstr;
h.YDisplayLabels = xtickstr;

title('Trained MT');

set(gca,'fontname','times');

% SM_t
subplot(2,2,4);

xtickstr = string(xtick);

h2 = heatmap(meanMat_SM_t, 'Colormap', hot);

h2 = gca;

caxis([0, 0.6]);

h2.XDisplayLabels = xtickstr;
h2.YDisplayLabels = xtickstr;

title('Trained SM');

set(gca,'fontname','times');

end