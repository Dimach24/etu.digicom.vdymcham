clc; close all; clear all;
%%
in = Simulink.SimulationInput("model_am");
snrs=11:21;
errors=zeros(1,length(snrs));
for i=1:length(snrs)
    snr=snrs(i);
    EbPerNo=snr;
    sim(in);
    errors(i)=Errors(1);
    fprintf("snr: %6.4g errorrate: %7.6g\n",snr,errors(i))
end
figure
scatter(snrs,errors)
yscale(gca(),"log")
%%