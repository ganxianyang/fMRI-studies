
load('Discovery_dataset_disgust.mat');
load('disgust_datasets_idx.mat');

nsub = 78;
nrepeat = 10; % for 10X10 cross-validation
nlevel = 5; % 5 ratings

for repeat = 1:nrepeat
    CVindex = GenerateCV(nsub, nlevel, repeat); 
    CVindex = CVindex(discovery_label_idx);
    [pred_outcome_r{repeat,1},dat{repeat,1}] = searchlight_predict(Discovery, 'alg', 'cv_svr', 'nfolds', CVindex, 'r', 3); % 3-voxel radius
end
save('searchlight_pred_outcome_r','pred_outcome_r');
save('searchlight_dat','dat');

