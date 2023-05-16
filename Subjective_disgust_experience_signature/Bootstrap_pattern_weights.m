
load('Discovery_dataset_disgust.mat')

[~, stats_boot] = predict(Discovery,  'algorithm_name', 'cv_svr', 'nfolds', 1, 'error_type', 'mse', 'useparallel', 0, 'bootweights', 'bootsamples', 10000); %'useparallel'=0 means don't use parallel processing

% Here, we replaced weight values with Z values
stats_boot_1=stats_boot;
stats_boot_1.weight_obj.dat=stats_boot_1.WTS.wZ';
data_threshold = threshold(stats_boot_1.weight_obj, .05, 'fdr');

write(data_threshold,'thresh','fname', 'VIDS_FDR_05.nii'); 