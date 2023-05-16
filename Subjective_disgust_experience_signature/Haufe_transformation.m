
load('Discovery_dataset_disgust.mat');

[~, stats] = predict(Discovery,  'algorithm_name', 'cv_svr', 'nfolds', 1, 'error_type', 'mse');

% Here, we used the script from Keith A. Bush which splits the data into n bricks
% https://github.com/kabush/kablab/blob/master/mvpa/fast_haufe.m
Haufe_pattern = fast_haufe(double(Discovery.dat'), double(stats.weight_obj.dat), 500);