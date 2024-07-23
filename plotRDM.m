% Untrained and Trained Condition Data
function [h] = plotRDM(group)

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

        newOrder = [1 3 2 4];
        M2 = M(newOrder,:);
        newM = M2(:,newOrder);

        fnSub = filteredS(ii).name(1:5);
        fnROI = filteredS(ii).name(12:13);

        subplot(3,4,ii);

        % M: 1- brush; 2- cubie; 3- mug; 4- smoothie
        % newM: 1- brush; 3- mug; 2- cubie; 4- smoothie

        xtick = ["Brush", "Mug", "Cubie", "Smoothie"];
        xtickstr = string(xtick);

        h = heatmap(newM, 'Colormap', hot);

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

        newOrder = [1 3 2 4];
        M2 = M(newOrder,:);
        newM = M2(:,newOrder);

        fnSub = filteredS_T(ii).name(1:5);
        fnROI = filteredS_T(ii).name(12:13);

        subplot(3,4,ii);

        % M: 1- brush; 2- cubie; 3- mug; 4- smoothie
        % newM: 1- brush; 3- mug; 2- cubie; 4- smoothie

        xtick = ["Brush", "Mug", "Cubie", "Smoothie"];
        xtickstr = string(xtick);

        h = heatmap(newM, 'Colormap', hot);

        h = gca;

        h.XDisplayLabels = xtickstr;
        h.YDisplayLabels = xtickstr;

        title(sprintf('%s %s',fnSub, fnROI));

        ii = ii+1;
        
        set(gca,'fontname','times')
    end
end
end