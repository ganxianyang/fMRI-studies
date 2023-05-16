%% VIDS, VIFS and PINES predict disgust (Table 1)
VIDS = fmri_data('VIDS.nii', 'GM_mask.nii');
VIFS = fmri_data('VIFS.nii', 'GM_mask.nii'); % Zhou et al. 2021, Nature Communications
PINES = fmri_data('PINES.nii', 'PINES_mask.nii'); % Chang et al. 2015, Plos Biology
load('Discovery_dataset_disgust.mat')
discovery_PINES_PE = double(Discovery.dat'*PINES.dat);
pred_discovery_r_PINES = corr(discovery_PINES_PE, Discovery.Y);
discovery_VIFS_PE = double(Discovery.dat'*VIFS.dat);
pred_discovery_r_VIFS = corr(discovery_VIFS_PE, Discovery.Y);
% pred_discovery_r_VIDS can be obtained from Predict_discovery_repeated_CV.m
load('validation_dataset_disgust.mat');
validation_PINES_PE = double(validation.dat'*PINES.dat);
pred_validation_r_PINES = corr(validation_PINES_PE, validation.Y);
validation_VIFS_PE = double(validation.dat'*VIFS.dat);
pred_validation_r_VIFS = corr(validation_VIFS_PE, validation.Y);
% pred_validation_r_VIDS can be obtained from Predict_validation.m

%% VIDS, VIFS and PINES predict general negative emotion (Table 1)
VIDS = fmri_data('VIDS.nii', 'GM_mask.nii');
VIFS = fmri_data('VIFS.nii', 'GM_mask.nii'); % Zhou et al. 2021, Nature Communications
PINES = fmri_data('PINES.nii', 'PINES_mask.nii'); % Chang et al. 2015, Plos Biology
% PINES dataset is available from https://neurovault.org/collections/1964/ we test the three signatures on PINES holdout dataset only
load('PINES_holdout.mat');
PINES_VIDS_PE = double(PINES_holdout.dat'*VIDS.dat);
pred_PINES_r_VIDS = corr(PINES_VIDS_PE, PINES_holdout.Y);
PINES_PINES_PE = double(PINES_holdout.dat'*PINES.dat);
pred_PINES_r_PINES = corr(PINES_PINES_PE, PINES_holdout.Y);
PINES_VIFS_PE = double(PINES_holdout.dat'*VIFS.dat);
pred_PINES_r_VIFS = corr(PINES_VIFS_PE, PINES_holdout.Y);

%% VIDS, VIFS and PINES predict fear (Table 1)
VIDS = fmri_data('VIDS.nii', 'GM_mask.nii');
VIFS = fmri_data('VIFS.nii', 'GM_mask.nii'); % Zhou et al. 2021, Nature Communications
PINES = fmri_data('PINES.nii', 'PINES_mask.nii'); % Chang et al. 2015, Plos Biology
% VIFS dataset is available from https://figshare.com/articles/dataset/Subjective_fear_dataset/13271102 we test the three signatures on VIFS discovery cohort only
load('Discovery_dataset.mat');
VIFS_VIDS_PE = double(discovery.dat'*VIDS.dat);
pred_VIFS_r_VIDS = corr(VIFS_VIDS_PE, discovery.Y);
VIFS_PINES_PE = double(discovery.dat'*PINES.dat);
pred_VIFS_r_PINES = corr(VIFS_PINES_PE, discovery.Y);

% for pred_VIFS_r_VIFS, we used 10X10 cross-validation:
load('fear_datasets_idx.mat')
nsub = 67;
nrepeat = 10; % for 10X10 cross-validation
nlevel = 5; % 5 ratings
predicted_ratings = zeros(length(discovery.Y),nrepeat);
for repeat = 1:nrepeat
    CVindex = GenerateCV(nsub, nlevel, repeat); 
    CVindex = CVindex(discovery_label_idx);
    [~, stats] = predict(discovery,  'algorithm_name', 'cv_svr', 'nfolds', CVindex, 'error_type', 'mse');
    predicted_ratings(:, repeat) = stats.yfit;
end
pred_VIFS_r_VIFS = corr(predicted_ratings,discovery.Y);