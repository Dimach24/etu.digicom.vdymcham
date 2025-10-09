clc; clear all ;
%%
snrs=-3:7;
errorRates=zeros(1,length(snrs));
in = Simulink.SimulationInput("model1");
time=175000;
allErrors=zeros(length(snrs),3);
fprintf("snr, dB | bits num | Error Rate | total errors\n")
for i=1:length(snrs)
    in=in.setModelParameter('StopTime',num2str(time));
    snr=snrs(i);
    out=sim(in);
    errors=out.get('errors');
    allErrors(i,1:3)=errors;
    errorRates(i) = errors(1);
    fprintf("%7d | %8d | %10.4g | %10d\n", snr,errors(3),errors(1),errors(2))
end
save("lab1_1.mat","errorRates","snrs","allErrors")

%%
load("lab1_1.mat")
figure
scatter(snrs,errorRates,Marker="x")
xlabel("SNR, dB")
ylabel("R")
yscale("log")
grid on;
saveas(gcf(),"R_SNR1","fig")
xlim([-4,10])
ylim([5e-4,1])


%%
snrs=-3:9;
errorRates=zeros(1,length(snrs));
in = Simulink.SimulationInput("model2");
time=175000;
allErrors=zeros(length(snrs),3);
fprintf("snr, dB | bits num | Error Rate | total errors\n")
for i=1:length(snrs)
    in=in.setModelParameter('StopTime',num2str(time));
    snr=snrs(i);
    out=sim(in);
    errors=out.get('errors');
    allErrors(i,1:3)=errors;
    errorRates(i) = errors(1);
    fprintf("%7d | %8d | %10.4g | %10d\n", snr,errors(3),errors(1),errors(2))
end
save("lab1_2.mat","errorRates","snrs","errors","allErrors")

%%
load("lab1_2.mat")
figure
scatter(snrs,errorRates,Marker="x")
xlabel("SNR, dB")
ylabel("R")
yscale("log")
grid on;
saveas(gcf(),"R_SNR2","fig")
xlim([-4,10])
ylim([5e-4,1])

%%