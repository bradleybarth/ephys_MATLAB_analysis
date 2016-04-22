function ephys_frequency_domain(data,info)
close all

Fs=info.header.sampleRate;
time=(1:length(data))/Fs;

figure
plot(time,data)


L=length(data);
ft=fft(data);
P2=abs(ft/L);
P1=P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f=Fs*(0:(L/2))/L;

figure
plot(f,P1)

cutoff_F=60;
half_cutBW=5;

ind=1;
while(ind*cutoff_F<Fs/2)
    cut_start=floor((cutoff_F*ind-half_cutBW)/Fs*L);
    cut_stop=floor((cutoff_F*ind+half_cutBW)/Fs*L);
    ind=ind+1;
    ft(cut_start+1:cut_stop,1)=zeros(1,cut_stop-cut_start,1);
    ft(L-cut_stop:L-cut_start-1,1)=zeros(cut_stop-cut_start,1);
end

P2=abs(ft/L);
P1=P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f=Fs*(0:(L/2))/L;

figure
plot(f,P1)

residue=ifft(ft);

figure
plot(time,residue)