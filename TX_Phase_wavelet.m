function [ waveletData ] = TX_Phase_wavelet( data_set,time,freq_range,window_length,channel,trial )
%  [ PLV ] = TX_PhaseLV( data_set,time,channel,trial )
%   Detailed explanation goes here

% clear cha

% for i = 1:floor(length(channel)/10)
%     cha{i} = channel((((i-1)*10)+1):(i*10));
% end
%
% if floor(length(channel)/10) < length(channel)/10
%     cha{i+1} = channel((i*10 + 1 ):end);
% end

%freq_range = 1:1:60;

%channel = 1:157;

disp(['Calculating Phase for trials...']);

phase_data = zeros(trial,length(channel),length(freq_range),length(time));


%window_length = [linspace(1.5,7,20) linspace(7,20,40)];



%% compute fourier
cfg = [];
cfg.trials     = 1:length(data_set.trial);
cfg.keeptrials = 'yes';
cfg.channel    = channel;
cfg.method     = 'wavelet';
cfg.width      = window_length;
cfg.output     = 'fourier';
cfg.foi        = freq_range;
cfg.toi        = time;
spectra_data = ft_freqanalysis(cfg,data_set);
temp_data = spectra_data.fourierspctrm;


trial_num = size(temp_data,1);
if trial > trial_num
    error('not enough trials')
end

phase_data(:,:,:,:) = temp_data(1:trial,channel,:,:);


for t = 1:trial
    waveletData{t} = squeeze(angle(phase_data(t,:,:,:)));
    
    
end


end
