function [filteredT] = get_mat_files(~)

% RDM original
dirName = '../../_OUTPUT/RDM_original/';

% % RDM Combined
% dirName = '../../_OUTPUT/RDM/';

% ------------- LOAD DATA ------------ %
fileS = dir( fullfile(dirName,'*.mat') );
files = struct2table(fileS);

% -- Subjects -- %
subUntrained = {'RBE03','IBE26','CLG22','SXG06','XHN30','ZWI22'};
subTrained = {'AZI25','CML23','JME15','JPA10','RSG06','SKI23'};

subUntrained = reshape(subUntrained,[],1);
subTrained = reshape(subTrained,[],1);
filteredC = cell(24,3);

for jj = 1:height(filteredC)
    % Untrained
    idxUnt = contains(files.name, subUntrained);
    filteredC = files.name(idxUnt,1); % if filenames are in subUntrained, move to filtered table
    filteredC(1:12,2) = {'untrained'};
    
    % Trained
    idxT = contains(files.name, subTrained);
    filteredC(13:24,1) = files.name(idxT,1); % if filenames are in subtrained, move to filtered table
    filteredC(13:24,2) = {'trained'};
    
    % ROI
    idxRoiMT = contains(files.name, 'MT');
    filteredC(idxRoiMT, 3) = {'MT'};
    idxRoiSM = contains(files.name, 'SM');
    filteredC(idxRoiSM, 3) = {'SM'};
end

filteredT = cell2table(filteredC, 'VariableNames', {'name', 'group', 'ROI'});

end