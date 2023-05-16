%% Fig2A surface plot (CanlabCore)
VIDS_thresholded = fmri_data('VIDS_FDR_05.nii', 'GM_mask.nii');
surface(VIDS_thresholded); % equivalent to 'surface(VIDS_thresholded,'left_cutaway');'

%% Fig2A axial/saggital/coronal maps (CanlabCore)
figure;o2 = fmridisplay;
% specifying 'axial'/'saggital'/'coronal' and slice_range you want to visualize for corresponding maps, like;
o2 = montage(o2, 'axial', 'slice_range', [-16 24], 'spacing', 2); % for z=53, similar coding; 
o2=addblobs(o2,region(VIDS_thresholded));
snapnow

%% Fig2B-2C
% see 
% Predict_discovery_repeated_CV.m, Predict_validation.m

%% Fig2D-2E
% the Fig. 2D,E were plotted using the fillsteplot function
load('TimeSeriesPE_discovery.mat'); % discovery cohort
% load('TimeSeriesPE_validation.mat'); % valdiation cohort

fillsteplot(r1, [255 127 0]/255);
hold on
fillsteplot(r2, [152 78 163]/255);
fillsteplot(r3, [77 175 74]/255);
fillsteplot(r4, [55 126 184]/255);
fillsteplot(r5, [239 118 119]/255);

set(gca,'XTickLabel', { '0','1', '2', '3', '4','5','6', '7', '8', '9'}, 'FontWeight','bold', 'linewidth', 4,'FontSize', 10);
set(gca,'YTick',-40:20:60,'FontWeight','bold', 'linewidth', 4,'FontSize', 10); % for discovery cohort
% set(gca,'YTick',-30:20:50,'FontWeight','bold', 'linewidth', 4,'FontSize', 10); % for valdiation cohort

plot(mean(r1),'ko','MarkerFaceColor',[255 127 0]/255,'MarkerSize',10,'LineWidth',2);
plot(mean(r2),'ko','MarkerFaceColor',[152 78 163]/255,'MarkerSize',10,'LineWidth',2);
plot(mean(r3),'ko','MarkerFaceColor',[77 175 74]/255,'MarkerSize',10,'LineWidth',2);
plot(mean(r4),'ko','MarkerFaceColor',[55 126 184]/255,'MarkerSize',10,'LineWidth',2);
plot(mean(r5),'ko','MarkerFaceColor',[228 26 28]/255,'MarkerSize',10,'LineWidth',2); 

ylabel('Disgust Pattern Expression','FontWeight','bold','FontSize', 20);
xlabel('TR ','FontWeight','bold','FontSize', 20);

%% Fig2F
% see 
% Predict_generalization.m