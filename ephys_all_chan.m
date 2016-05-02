function ephys_all_chan(folder)
close all

finfo=dir(folder);


for f=1:4
    fig{f}=figure;
end

for id=6:length(finfo)-4
    s=[folder,'/',finfo(id).name];
    if length(finfo(id).name)==19
        ch=str2num(finfo(id).name(7:8));
    elseif length(finfo(id).name)==18
        ch=str2num(finfo(id).name(7));
    else
        disp('error')
        return
    end
    disp(s)
    [data,~,info]=load_open_ephys_data_faster(s);
    fignmb=ceil(ch/8);
    blk=ch-(fignmb-1)*8;

    Fs=info.header.sampleRate;
    time=(1:length(data))/Fs;

    figure(fig{fignmb})
    subplot(8,1,blk)
    plot(time,data)
    ylabel(['CH',num2str(ch)])
end