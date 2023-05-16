%% Fig5A-5B brain maps
% The plot of 'axial'/'saggital'/'coronal' images in Fig5A-5B were similar to Fig2A (CanlabCore);
% and the brain activation images were plotted using the brain_activation_wani(cocoanCORE) function.

%% Fig5A-5B histogram draw
load('searchlight_discovery_repeat.mat');
h = histogram(pred_outcome_r);
h.FaceColor = [0.0902 0.6863 0.9216]; 
h.EdgeColor = [0.9137 0.9255 0.9373]; 
h.NumBins = 140; % specify the number of bins

%% Fig5C-5D
% The lineplot drawing is similar to that used in Predict_discovery_repeated_CV.m

%% Fig5E
load('Disgust_spatial_scale_10CV_1000iters.mat')

num_feats_full = num_feats.num_feats_full;
num_feats_within = num_feats.num_feats_within;
num_feats_conscious = num_feats.num_feats_conscious;
num_feats_subcortical = num_feats.num_feats_subcortical;

pred_outcome_r_full = pred_outcome.pred_outcome_r_full;
pred_outcome_r = pred_outcome.pred_outcome_r;
pred_outcome_r_conscious = pred_outcome.pred_outcome_r_conscious;
pred_outcome_r_subcortical = pred_outcome.pred_outcome_r_subcortical;


num_iterations = 1000;
num_parcels = 7;

mycolors={[127 127 127]/255 [227 119 194]/255  [188 189 34]/255  [148 103 189]/255  [214 39 40]/255  [44 160 44]/255  [31 119 180]/255 [255 127 14]/255 [140 86 75]/255};

for it=1:num_iterations
    [~, ~,x_wb(it,:),y_wb(it,:)] = createFit(num_feats_full(:)', pred_outcome_r_full(it,:),'color',[.2 .2 .2],'linewidth',3);
    [~, ~,x_cons(it,:),y_cons(it,:)] = createFit(num_feats_conscious(:)', pred_outcome_r_conscious(it,:),'color',mycolors{end-1},'linewidth',3);
    [~, ~,x_subcortical(it,:),y_subcortical(it,:)] = createFit(num_feats_subcortical(:)', pred_outcome_r_subcortical(it,:),'color',mycolors{end},'linewidth',3);
    for r=1:num_parcels
        r_within=squeeze((pred_outcome_r(it,r,1:size(pred_outcome_r,3))));
        [~, ~,x{it,r},y{it,r}] = createFit(num_feats_within(r,:)', r_within(:),'color',mycolors{r},'linewidth',3);
    end
end

close all;
figure;
hold on;
boundedline(mean(x_wb),mean(y_wb), std(y_wb),'alpha', 'cmap',[.2 .2 .2]);
boundedline(mean(x_cons), mean(y_cons), std(y_cons),'alpha', 'cmap',mycolors{end-1});
boundedline(mean(x_subcortical), mean(y_subcortical), std(y_subcortical),'alpha', 'cmap',mycolors{end});
for r=1:num_parcels
    clear to_plot_x to_plot_y
    for i=1:size(x,1)
        to_plot_x(i,:)=x{i,r};
        to_plot_y(i,:)=y{i,r};
    end
    x_parcels{r, 1} = mean(to_plot_x);
    y_parcels{r, 1} = mean(to_plot_y);
    boundedline(mean(to_plot_x), mean(to_plot_y), std(to_plot_y),'alpha', 'cmap',mycolors{r}); 
end

h=findobj(gca,'type','line');
set(h,'linewidth',2);
set(gca,'XScale','log')
atlas_labels=networknames;

% pay attention to the legend, which was tested on MATLAB 2015b (might be different on later version?)
% legend(h(1:end),{atlas_labels{:} 'All Parcels' 'Whole-brain'},'Location','SouthEast');
legend(h(end:-1:1),{'Whole-brain', atlas_labels{end-1}, atlas_labels{end}, atlas_labels{1:7}},'Location','SouthEast');
xlabel('Number of voxels', 'FontWeight', 'BOLD')
ylabel('Prediction-outcome correlation','FontWeight', 'BOLD')
xlim([40 1000000])
set(gca,'ylim',[0.1,0.7], 'YTick', 0.1:0.1:0.7, 'LineWidth',2, 'FontWeight', 'BOLD') 
plot(num_feats_full, mean(pred_outcome_r_full), '.', 'markersize', 20, 'color',[.2 .2 .2]);
plot(num_feats_conscious, mean(pred_outcome_r_conscious), '.', 'markersize', 20, 'color',mycolors{end-1});
plot(num_feats_subcortical, mean(pred_outcome_r_subcortical), '.', 'markersize', 20, 'color',mycolors{end});
for  r=1:num_parcels
    plot(num_feats_within(r,:), mean(squeeze(pred_outcome_r(:, r, :))), '.', 'markersize', 20, 'color',mycolors{r});
end

% save the figure with 300dpi
print('-dtiff','-r300','Network-based_predictions_discovery')
