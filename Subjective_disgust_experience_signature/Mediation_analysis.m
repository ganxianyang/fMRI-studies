%% discovery cohort: VIDS response, disgust rating, and PINES response
clear,clc
load('Mediation_disgust_discovery_VIF3.mat')
for i = 1:78
    disgust_PE{1,i}=mean(PEs{i,1},2)
end

% PINES --> VIDS --> DISGUST RATING
[paths, toplevelstats, indlevelstats] = mediation(PINES_PE_discovery, disgust_rating_discovery, disgust_PE, 'plots','verbose', 'boot', 'bootsamples', 10000, 'doCIs');

% VIDS --> PINES --> DISGUST RATING
[paths, toplevelstats, indlevelstats] = mediation(disgust_PE, disgust_rating_discovery, PINES_PE_discovery, 'plots','verbose', 'boot', 'bootsamples', 10000, 'doCIs');


%% validation cohort:VIDS response, disgust rating, and PINES response
clear,clc
load('Mediation_disgust_validation_VIF3.mat')
% PINES --> VIDS --> DISGUST RATING
[paths, toplevelstats, indlevelstats] = mediation(PINES_PE_validation, disgust_rating_validation, disgust_PE, 'plots','verbose', 'boot', 'bootsamples', 10000, 'doCIs');

% VIDS --> PINES --> DISGUST RATING
[paths, toplevelstats, indlevelstats] = mediation(disgust_PE, disgust_rating_validation, PINES_PE_validation, 'plots','stats','verbose', 'boot', 'bootsamples', 10000, 'doCIs');


%% discovery cohort: VIDS response, disgust rating, and VIFS response
clear,clc
load('Mediation_fear_disgust_discovery_VIF3.mat')
for i = 1:78
    disgust_PE{1,i}=mean(PEs{i,1},2)
end
% VIFS --> VIDS --> DISGUST RATING
[paths, toplevelstats, indlevelstats] = mediation(VIFS_PE_discovery, disgust_rating_discovery, disgust_PE, 'plots','verbose', 'boot', 'bootsamples', 10000, 'doCIs');

% VIDS --> VIFS --> DISGUST RATING
[paths, toplevelstats, indlevelstats] = mediation(disgust_PE, disgust_rating_discovery, VIFS_PE_discovery, 'plots','verbose', 'boot', 'bootsamples', 10000, 'doCIs');

% validation dataset
clear,clc
load('Mediation_fear_disgust_validation_VIF3.mat')
% VIFS --> VIDS --> DISGUST RATING
[paths, toplevelstats, indlevelstats] = mediation(VIFS_PE_validation, disgust_rating_validation, disgust_PE, 'plots','verbose', 'boot', 'bootsamples', 10000, 'doCIs');

% VIDS --> VIFS --> DISGUST RATING
[paths, toplevelstats, indlevelstats] = mediation(disgust_PE, disgust_rating_validation, VIFS_PE_validation, 'plots','stats','verbose', 'boot', 'bootsamples', 10000, 'doCIs');