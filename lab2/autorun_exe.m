clc; close all; clear all;
postfix = "_2023a";

%%
[snrs_am,errors_am] =run_model("am" + postfix, 11:21);


%%
[snrs_pm,errors_pm] =run_model("pm" + postfix, 6:16);
%%
[snrs_qam16,errors_qam16] =run_model("qam_gray" + postfix, 2:12);
figure
scatter(snrs_am,errors_am,Marker="+")
hold on;
scatter(snrs_pm,errors_pm,Marker="x")
scatter(snrs_qam16,errors_qam16,Marker="^")

yscale(gca(),"log")
xlabel("Eb/No")
ylabel("P_{ош}")
grid on
legend( "АМ", "ФМ", "QAM")
%%

%%
[snrs_qam_bin,errors_qam_bin] =run_model("qam_bin" + postfix,2:12);
figure
scatter(snrs_qam16,errors_qam16,Marker="+")
hold on;
scatter(snrs_qam_bin,errors_qam_bin,Marker="x")

yscale(gca(),"log")
xlabel("Eb/No")
ylabel("P_{ош}")
grid on
legend("Код Грея", "Последоватльный\nподсчёт")

%%
[snrs_qam64,errors_qam64] =run_model("qam_64" + postfix,6:16);
[snrs_qam4,errors_qam4] =run_model("qam_4" + postfix,-2:8);
figure
scatter(snrs_qam4,errors_qam4,Marker="+")
hold on;
scatter(snrs_qam16,errors_qam16,Marker="x")
scatter(snrs_qam64,errors_qam64,Marker="^")
yscale(gca(),"log")
xlabel("Eb/No")
ylabel("P_{ош}")
grid on
legend( "QAM-4", "QAM-16", "QAM-64")
%%

save("lab2.mat", ...
    "snrs_am","snrs_pm","snrs_qam4","snrs_qam16","snrs_qam_bin","snrs_qam64", ...
    "errors_am","errors_pm","errors_qam4","errors_qam16","errors_qam_bin","errors_qam64" ...
)
function [snrs,errors] = run_model(name,snrs)
    in = Simulink.SimulationInput("model_"+name);
    errors=zeros(1,length(snrs));
    for i=1:length(snrs)
        snr=snrs(i);%%
        in=in.setVariable("EbPerNo",snr);
        out=sim(in);
        errors(i)=out.Errors(1);
        fprintf("snr: %6.4g errorrate: %7.6g\n",snr,errors(i))
    end
end