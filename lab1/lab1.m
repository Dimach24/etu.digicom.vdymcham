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
    errorRates(i) = out.errors(1);
    if out.errors(2)<100
        fprintf("For snr %d got %d errors. No less than 100 expected.\n",snr,out.errors(2))
    end
    fprintf("%3d: %10.6g\n", snr,errorRates(i))
end
%%
scatter(snrs,errorRates*100,Marker="x")
xlabel("SNR, dB")
ylabel("Error rate, %")
grid on;
