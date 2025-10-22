clc; clear all ;
%%
snrs=-3:7;
errorRates=zeros(1,length(snrs));
in = Simulink.SimulationInput("model1");
allErrors=zeros(length(snrs),3);
fprintf("snr, dB | bits num | Error Rate | total errors\n")
for i=1:length(snrs)
    snr=snrs(i);
    out=sim(in);
    errors=out.get('errors');
    allErrors(i,1:3)=errors;
    errorRates(i) = errors(1);
    fprintf("%7d | %8d | %10.4g | %10d\n", snr,errors(3),errors(1),errors(2))
end

save("lab1_1.mat","errorRates","snrs","allErrors")

%%
snrs=-3:7;
load("lab1_1.mat")
m_std_nosc = sqrt(allErrors(:,1) .* (1 - allErrors(:,1))./allErrors(:,3)).';

figure
scatter(snrs,errorRates,Marker= "x", LineWidth=0.5)
hold on
scatter(snrs,errorRates - m_std_nosc, Marker= "_")
scatter(snrs,errorRates + m_std_nosc, Marker= "_")
scatter(snrs,qfunc(sqrt(2 * 10.^(snrs/10))), Marker= "o")
legend("эксп.", '', '', "теор.")

xlabel("Es/N0, дб")
ylabel("Pош")
yscale("log")
grid on;
saveas(gcf(),"R_SNR1","fig")
xlim([-4,10])
ylim([5e-4,1])


%%
snrs=-3:9;
errorRates=zeros(1,length(snrs));
in = Simulink.SimulationInput("model2");

allErrors=zeros(length(snrs),3);
fprintf("snr, dB | bits num | Error Rate | total errors\n")
for i=1:length(snrs)
    snr=snrs(i);
    out=sim(in);
    errors=out.get('errors');
    allErrors(i,1:3)=errors;
    errorRates(i) = errors(1);
    fprintf("%7d | %8d | %10.4g | %10d\n", snr,errors(3),errors(1),errors(2))
end

save("lab1_2.mat","errorRates","snrs","errors","allErrors")

%%
snrs=-3:9;
load("lab1_2.mat")
m_std_sc = sqrt(allErrors(:,1) .* (1 - allErrors(:,1))./allErrors(:,3)).';

figure
scatter(snrs,errorRates,Marker= "x", LineWidth=0.5)
hold on
scatter(snrs,errorRates - m_std_sc, Marker= "_")
scatter(snrs,errorRates + m_std_sc, Marker= "_")
scatter(snrs,descramblerError(qfunc(sqrt(2 * 10.^(snrs/10)))), Marker= "o")
legend("эксп.", '', '', "теор.")

xlabel("Es/N0, дб")
ylabel("Pош")
yscale("log")
grid on;
saveas(gcf(),"R_SNR2","fig")
xlim([-4,10])
ylim([1e-5,1])
% hold on
% scatter(snrs, errorRates + m_std,Marker="^");
% scatter(snrs, errorRates - m_std,Marker="v");

%%

function out = descramblerError(p)
out = - 8*p.^4 + 16*p.^3 - 12*p.^2 + 4*p;
end