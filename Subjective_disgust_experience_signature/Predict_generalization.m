%% VIDS predicts disgust vs neutral pictures (disgust experience)
VIDS = fmri_data('VIDS.nii', 'GM_mask.nii');
% The disgust experience data is from Chen et al. (2021, Neural Plasticity)
load('disgust_experience.mat') 
disgust_experience_VIDS_PE = double(disgust_experience.dat'*VIDS.dat);
ROC_disgust_experience = roc_plot(disgust_experience_VIDS_PE, [ones(26,1);zeros(26,1)], 'twochoice'); % two-choice, 26 subjects