clc; clear all ;
snrs=-3:7;
errorRates=zeros(1,length(snrs));
for i=1:length(snrs)
    snr=snrs(i);
    out=sim("model1");
    errorRates(i) = out.errors(1);
end
stem(snrs,errorRates,Marker="pentagram")
