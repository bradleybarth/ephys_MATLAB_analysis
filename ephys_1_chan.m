function ephys_1_chan(folder,ch)

figure

s=[folder,'/100_CH',num2str(ch),'.continuous'];
disp(s)
[data,~,info]=load_open_ephys_data_faster(s);

Fs=info.header.sampleRate;
time=(1:length(data))/Fs;
plot(time,data)
title(['CH',num2str(ch)])
xlabel('seconds')
ylabel('microVolts')