% Here, we showed an example of random sampling predictions using the visual network

load('disgust_datasets_idx.mat');
visual_predi_outco_r_50voxels=zeros(1000,1); 
for i = 1:1000
    load('Discovery_visual_network.mat');
    nsub = 78;
    nrepeat = 10; % for 10X10 cross-validation
    nlevel = 5; % 5 ratings
    predicted_ratings = zeros(length(Discovery_visual_network.Y),nrepeat);
    
    rng('shuffle'); 
    index = randsample(1:length(Discovery_visual_network.dat), 50);  % the number of randomly selected 50 voxels; random selection of 150/250/500... is similar
    randomly_selected = Discovery_visual_network.dat(index,:);
    Discovery_visual_network.dat=randomly_selected; 

    for repeat = 1:nrepeat
        CVindex = GenerateCV(nsub, nlevel, repeat);
        CVindex = CVindex(discovery_label_idx);
        [~, stats] = predict(Discovery_visual_network,  'algorithm_name', 'cv_svr', 'nfolds', CVindex, 'error_type', 'mse');
        predicted_ratings(:, repeat) = stats.yfit;
    end
    
    true_ratings = Discovery_visual_network.Y;
    prediction_outcome_corrs = corr(true_ratings, predicted_ratings); 
    visual_predi_outco_r_50voxels(i,1)=mean(prediction_outcome_corrs);
end
save('visual_predi_outco_r_50voxels.mat','visual_predi_outco_r_50voxels');