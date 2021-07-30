% 31/05/2021 code revise %
% Common patch seperation code for all participants %
% Leafy Behera & Peeusa Mitra %

%% Patch Seperation Code
    load('Experiment_P20foraging_2017-06-26.mat') % loading the exp data file (This oarticular file is for participant number 20)
    ss= {bhvmat.UserVars.rwrd}; % stores all rewards (this is cell)
    s_1=[ss{:}];                % reward values in stay trials( leave trials have 0 values)
    d=find(cellfun(@isempty,ss)); % to find the empty cells (leave trials)
    vv= find(~cellfun(@isempty,ss)); % to find the cells with reward values (stay trials)
    patch={}; % stores last stay trial of every patch
    patch_1={}; % first stay trials of the next patch
    for j= 1:length(vv)-1
        if vv(j+1)-vv(j)~= 1 % subtracting consecutive trial numbers
            patch=[patch,vv(j)];
            patch_1=[patch_1,vv(j+1)];
        end
    end
    last_stay_trial=[patch{:}]; % the last stay trial of every patch
    first_stay_trial=[patch_1{:}]; % the first stay trial of every patch (from patch 2 onwards)
    next={};
    all_patches={};
    for i= 1:length(last_stay_trial)-1
        patch1= 1:last_stay_trial(1)+1; % the first patch
        next= [next,first_stay_trial(i):last_stay_trial(i+1)+1]; % seperate all patches (from the second patch onwards)
        last= first_stay_trial(length(first_stay_trial)):length(ss);
    end
    all_patches= [all_patches,patch1,next,last]; % Stores all seperated patches

%end     
