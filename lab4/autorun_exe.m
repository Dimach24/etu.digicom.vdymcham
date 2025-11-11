clc; clear all ;
%%
snrs=0:2:12;
model = Simulink.SimulationInput("model_fm2");
errors=zeros(1,length(snrs));
for i=1:length(snrs)
    in=model.setVariable("EbPerNo",snrs(i));
    out=sim(in);
    errors(i)= out.Errors(1);
    if (out.Errors(2)<100)
        disp("Warning: errors count less then 100",errors)
    end
end
figure
scatter(snrs,errors,Marker="+");
yscale(gca(),"log")
xlabel("Eb/No")
ylabel("P_{ош}")
xlim([-1,13])
grid on
save("fm2_awgn.mat","errors","snrs")
clear all;
%%
snrs=0:5:30;
model = Simulink.SimulationInput("model_fm2_siso");
errors=zeros(1,length(snrs));
for i=1:length(snrs)
    in=model.setVariable("EbPerNo",snrs(i));
    out=sim(in);
    errors(i)= out.Errors(1);
    if (out.Errors(2)<100)
        disp("Warning: errors count less then 100",errors)
    end
end
figure
scatter(snrs,errors,Marker="+");
yscale(gca(),"log")
xlabel("Eb/No")
ylabel("P_{ош}")
xlim([-1,31])
grid on
save("fm2_awgn_oneRay.mat","errors","snrs")
clear all;
%%
model = Simulink.SimulationInput("model_fm2_siso_visual");
out=sim(model.setVariable("EbPerNo",20));
figure
plot(out.Scope.time,squeeze(out.Scope.signals.values))
xlabel('t, с')
ylabel('|x|')
savefig("scope_1ray.fig")
close
figure
bar(0:.1:4.999,out.Hist,1)
xlabel('|x|^2')
ylabel('P(|x|^2)')
savefig("hist_1ray.fig")
clear all;
close
%%
model = Simulink.SimulationInput("model_fm2_2siso_visual");
out=sim(model.setVariable("EbPerNo",20));
figure
plot(out.Scope.time,squeeze(out.Scope.signals.values))
xlabel('t, с')
ylabel('|x|')
savefig("scope_2ray.fig")
close
figure
bar(0:.1:4.999,out.Hist,1)
xlabel('|x|^2')
ylabel('P(|x|^2)')
savefig("hist_2ray.fig")
mean_power=out.MeanPower;
close
%%
model = Simulink.SimulationInput("model_fm2_2siso");
snrs=0:2:20;
errors=zeros(1,length(snrs));
for i=1:length(snrs)
    out=sim(model.setVariable("EbPerNo",snrs(i)));
    errors(i)= out.Errors(1);
    if (out.Errors(2)<100)
        disp("Warning: errors count less then 100",errors)
    end
end

figure
scatter(snrs,errors,Marker="+");
yscale(gca(),"log")
xlabel("Eb/No")
ylabel("P_{ош}")
xlim([-1,13])
grid on
save("fm2_awgn_twoRaysMax.mat","errors","snrs","mean_power")
clear all;
%%
model = Simulink.SimulationInput("model_fm2_2siso_opt");
snrs=0:2:14;
errors=zeros(1,length(snrs));
for i=1:length(snrs)
    out=sim(model.setVariable("EbPerNo",snrs(i)));
    errors(i)= out.Errors(1);
    if (out.Errors(2)<100)
        disp("Warning: errors count less then 100",errors)
    end
end
figure
scatter(snrs,errors,Marker="+");
yscale(gca(),"log")
xlabel("Eb/No")
ylabel("P_{ош}")
xlim([-1,13])
grid on
save("fm2_awgn_twoRayMRC.mat","errors","snrs")
clear all;