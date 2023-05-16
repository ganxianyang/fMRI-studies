
load('Discovery_dataset_disgust.mat');
load('disgust_datasets_idx.mat');

data1 = zeros(length(Discovery.Y),1);
for i =1: 78
    if i<=72
        data1((5*(i-1)+1):5*i)=i;
    else
        data1((360+(4*((i-72)-1)+1)):(4*(i-72)+360))=i;
    end
end
nsub = 78;
nrepeat = 10; % for 10X10 cross-validation
nlevel = 5; % 5 ratings
svrobj = svr({'C=1', 'optimizer="andre"', kernel({'rbf', 1})})
predicted_ratings = zeros(length(Discovery.Y),nrepeat);
for repeat = 1:nrepeat
    CVindex = GenerateCV(nsub, nlevel, repeat);
    CVindex = CVindex(discovery_label_idx);
    for i =1:10
        sub_ind=find(CVindex==i);
        test_num=unique(data1(CVindex==i));
        xtrain=Discovery.dat(:,CVindex~=i);
        ytrain= Discovery.Y(CVindex~=i);
        
        dataobj = data('spider data', double(xtrain)', ytrain);
        % Training
        svrobj = svr({'C=1', 'optimizer="andre"'})
        [res, svrobj] = train(svrobj, dataobj);
        w = get_w(svrobj);
        % Test data
        Input_data_path='' % specify the path where you put the trialwise data
        for j=1:length(test_num)
            listing_subject= dir(Input_data_path);
            listing_data= dir([Input_data_path listing_subject(test_num(j)+4).name]); 
            load([Input_data_path listing_subject(test_num(j)+4).name '\' listing_data(3).name]);
            xtest=Discovery_trialwise.dat;
            PE = double(xtest')*w';
            [corr_value{repeat,i,j},p]= corr(PE,Discovery_trialwise.Y);
            p_corr_value{repeat,i,j}=p; 
        end
        test_num_sub_indice{repeat,i}=test_num;
    end
end