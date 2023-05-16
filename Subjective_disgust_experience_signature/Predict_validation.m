
load('disgust_datasets_idx.mat')
load('Discovery_dataset_disgust.mat')
svrobj = svr({'C=1', 'optimizer="andre"', kernel('linear')});
dataobj = data('spider data', double(Discovery.dat)', Discovery.Y);
clear Discovery
[~, svrobj] = train(svrobj, dataobj, loss);
weights = get_w(svrobj)';
bias = svrobj.b0;

load('validation_dataset_disgust.mat');
load('validation_label_idx.mat');
predicted_ratings = double(validation.dat)'*weights+bias;
true_ratings = validation.Y;
nsub = 30;
nlevel = 5;
subject = repmat(1:nsub, nlevel,1);
subject = subject(:);
subject = subject(validation_label_idx);

%% prediction-outcome corrs
prediction_outcome_corr = corr(predicted_ratings, true_ratings);
within_subj_corrs = zeros(nsub, 1);
within_subj_rmse = zeros(nsub, 1);
for i = 1:nsub
    subY = true_ratings(subject==i);
    subyfit = predicted_ratings(subject==i);
    within_subj_corrs(i, 1) = corr(subY, subyfit);
    err = subY - subyfit;
    mse = (err' * err)/length(err);
    within_subj_rmse(i, 1) = sqrt(mse);
end

%% classification
Accuracy_per_level = zeros(1, 4);
Accuracy_se_per_level = zeros(1, 4);
Accuracy_p_per_level = zeros(1, 4);
Accuracy_low_medium_high = zeros(1, 3);
Accuracy_se_low_medium_high = zeros(1, 3);
Accuracy_p_low_medium_high = zeros(1, 3);
PE = predicted_ratings(:);
PE = [PE(1:end-4);PE(end-3:end); NaN]; % include rating 5 for the last subject
PE = reshape(PE, [5, nsub])';
PE_low = nanmean(PE(:, 1:2), 2);
PE_medium = PE(:, 3);
PE_high = nanmean(PE(:, 4:5), 2);
% level 2 vs. 1
ROC = roc_plot([PE(:, 2);PE(:,1)], [ones(nsub,1);zeros(nsub,1)], 'twochoice');
Accuracy_per_level(1) = ROC.accuracy;
Accuracy_se_per_level(1) = ROC.accuracy_se;
Accuracy_p_per_level(1) = ROC.accuracy_p;
% level 3 vs. 2
ROC = roc_plot([PE(:, 3);PE(:,2)], [ones(nsub,1);zeros(nsub,1)], 'twochoice');
Accuracy_per_level(2) = ROC.accuracy;
Accuracy_se_per_level(2) = ROC.accuracy_se;
Accuracy_p_per_level(2) = ROC.accuracy_p;
% level 4 vs. 3
ROC = roc_plot([PE(:, 4);PE(:,3)], [ones(nsub,1);zeros(nsub,1)], 'twochoice');
Accuracy_per_level(3) = ROC.accuracy;
Accuracy_se_per_level(3) = ROC.accuracy_se;
Accuracy_p_per_level(3) = ROC.accuracy_p;
% level 5 vs. 4
ROC = roc_plot([PE(1:end-1, 5);PE(1:end-1,4)], [ones(nsub-1,1);zeros(nsub-1,1)], 'twochoice');
Accuracy_per_level(4) = ROC.accuracy;
Accuracy_se_per_level(4) = ROC.accuracy_se;
Accuracy_p_per_level(4) = ROC.accuracy_p;
% low vs. meduim
ROC = roc_plot([PE_medium;PE_low], [ones(nsub,1);zeros(nsub,1)], 'twochoice');
Accuracy_low_medium_high(1) = ROC.accuracy;
Accuracy_se_low_medium_high(1) = ROC.accuracy_se;
Accuracy_p_low_medium_high(1) = ROC.accuracy_p;
% medium vs. high
ROC = roc_plot([PE_high;PE_medium], [ones(nsub,1);zeros(nsub,1)], 'twochoice');
Accuracy_low_medium_high(2) = ROC.accuracy;
Accuracy_se_low_medium_high(2) = ROC.accuracy_se;
Accuracy_p_low_medium_high(2) = ROC.accuracy_p;
% low vs. high
ROC = roc_plot([PE_high;PE_low], [ones(nsub,1);zeros(nsub,1)], 'twochoice');
Accuracy_low_medium_high(3) = ROC.accuracy;
Accuracy_se_low_medium_high(3) = ROC.accuracy_se;
Accuracy_p_low_medium_high(3) = ROC.accuracy_p;

%% plot
create_figure('Whole-brain Prediction');
predicted_ratings_reshaped = [predicted_ratings(1:end-4);predicted_ratings(end-3:end); NaN]; % include rating 5 for the last  subject
predicted_ratings_reshaped = reshape(predicted_ratings_reshaped, [5, nsub])';
lineplot_columns(predicted_ratings_reshaped, 'color', [0.4510 0.6392 0.8510], 'markerfacecolor', [0.4510 0.6392 0.8510]);
xlabel('True Rating');
ylabel('Predicted Rating')
set(gca,'FontSize',20);
set(gca,'linewidth', 2)
set(gca, 'XTick', 1:5)
xlim([0.8 5.2])
ylim([0 5])
set(gcf, 'Color', 'w');
print('-dpdf','-r300','Fig 2C')