clc; clear all ;
%%
snrs=-3:7;
errorRates=zeros(1,length(snrs));
in = Simulink.SimulationInput("model1");
time=100000;
for i=1:length(snrs)
    in=in.setModelParameter('StopTime',num2str(time));
    snr=snrs(i);
    out=sim(in);
    errors=out.get('errors');
    errorRates(i) = errors(1);
    fprintf("For snr %d got %d errors. At least 100 expected.\n",snr,errors(2))
    fprintf("%3d: %10.6g\n", snr,errorRates(i))
end
%%
figure
scatter(snrs,errorRates,Marker="x")
xlabel("SNR, dB")
ylabel("R")
yscale("log")
grid on;
saveas(gcf(),"R_SNR1","fig")
xlim([min(snrs)-1,max(snrs)+1])


%%
save("lab1_1.mat","errorRates","snrs")

%%
snrs=-3:9;
errorRates=zeros(1,length(snrs));
in = Simulink.SimulationInput("model2");
time=100000;
for i=1:length(snrs)
    in=in.setModelParameter('StopTime',num2str(time));
    snr=snrs(i);
    out=sim(in);
    errors=out.get('errors');
    errorRates(i) = errors(1);
    fprintf("For snr %d got %d errors. At least 100 expected.\n",snr,errors(2))
    fprintf("%3d: %10.6g\n", snr,errorRates(i))
end
%%
figure
scatter(snrs,errorRates,Marker="x")
xlabel("SNR, dB")
ylabel("R")
yscale("log")
grid on;
saveas(gcf(),"R_SNR2","fig")
xlim([min(snrs)-1,max(snrs)+1])


%%
save("lab1_2.mat","errorRates","snrs")
%%