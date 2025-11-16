close all

q = {db2pow(q_dB{1}), db2pow(q_dB{2}), db2pow(q_dB{3}), db2pow(q_dB{4})};

P_b_theor = {
    1/2 * exp(- q{1} / 2), ... % 4.3.1 aka AWGN 
    1 ./ (2 + q{2}), ... % 4.3.2 aka RAYLEIGH
    4 ./ (q{3}.^2 + 6 * q{3} + 8), ... % 4.3.4 aka STRONG_CHOICE
    0.5 * (2 ./ (q{4} + 2)) .^ 2 % 4.3.5 aka OPTIUM_SUM
    };

q0 = 1; % idk
w_theor = {
    1 ./ q{2} .* exp(- q{2} ./ q0),
    2 ./ q0 .* (1 - exp(- q{3} ./ q0)) .* exp(- q{3} ./ q0)
    };

markers = {"square", "x", "+", "o"};

figure
grid on
hold on
for i = 1:4
plot(q_dB{i}, log10(P_b_theor{i}),"Marker",markers{i}, "LineStyle","--")
end
xlabel('E_b/N_0, дБ'); ylabel("log_{10}(P_b)")
legend( ...
    strcat(names{1},' (теор.)'), ...
    strcat(names{2},' (теор.)'), ...
    strcat(names{3},' (теор.)'), ...
    strcat(names{4},' (теор.)') ...
    )

figure
grid on
plot(q_dB{2}, w_theor{1},"Marker",markers{2}, "LineStyle","--")

figure
grid on
plot(q_dB{3}, w_theor{2},"Marker",markers{2}, "LineStyle","--")
