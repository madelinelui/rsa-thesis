% Untrained and Trained Condition Data
function [h] = plotRDMCombined(group)

dirName = '../../_OUTPUT/RDM/';

filteredT = get_mat_files();
    
% Load data
N = height(filteredT);

filteredS = table2struct(filteredT);

filteredS_T = cell(12,3);
filteredS_T = cell2table(filteredS_T, 'VariableNames', {'name', 'group', 'ROI'});
filteredS_T = table2struct(filteredS_T);

if group == 0 % untrained
    figure('Position', [317,96.33,1786,910.66]);
    sgtitle('Familiar vs. Unfamiliar: Untrained','fontname','times', 'fontweight', 'bold');
    for ii = 1:12

        S = load(filteredS(ii).name);
        M = cell2mat(struct2cell(S));

        fnSub = filteredS(ii).name(1:5);
        fnROI = filteredS(ii).name(12:13);

        subplot(3,4,ii);

        xtick = ["Familiar", "Unfamiliar"];
        xtickstr = string(xtick);

        h = heatmap(M, 'Colormap', hot);
        
        caxis([0, 0.6]);

        h = gca;

        h.XDisplayLabels = xtickstr;
        h.YDisplayLabels = xtickstr;

        title(sprintf('%s %s',fnSub, fnROI));

        ii = ii+1;
        
        set(gca,'fontname','times')
    end
    
elseif group == 1 % trained
    filteredS_T = filteredS(13:24,:);
    figure('Position', [317,96.33,1786,910.66]);
    sgtitle('Familiar vs. Unfamiliar: Trained','fontname','times', 'fontweight', 'bold');
    for ii = 1:12

        S = load(filteredS_T(ii).name);
        M = cell2mat(struct2cell(S));

        fnSub = filteredS_T(ii).name(1:5);
        fnROI = filteredS_T(ii).name(12:13);

        subplot(3,4,ii);

        xtick = ["Familiar", "Unfamiliar"];
        xtickstr = string(xtick);

        h = heatmap(M, 'Colormap', hot);
        
        caxis([0, 0.6]);

        h = gca;

        h.XDisplayLabels = xtickstr;
        h.YDisplayLabels = xtickstr;

        title(sprintf('%s %s',fnSub, fnROI));

        ii = ii+1;
        
        set(gca,'fontname','times')
    end
end