function SN_analysis(filename, neuron)

results = load(filename, neuron);

S = results.S;
T = results.T;

 
S_i = S(:, neuron);
[peakValues, indexes] = findpeaks(S_i);
tValues = T(indexes);

figure(1)
plot(T, S_i,'b-')
hold on

plot([tValues(2), tValues(2)],[0, peakValues(2)],'r-')%, 'DisplayName','Amplitude')
plot([tValues(2), tValues(3)], [0.25, 0.25], 'g-')%,'DisplayName','Wavelength')%[p3(2)+0.007, p3(2)+0.007])
plot([tValues(3), tValues(3)],[0, peakValues(3)],'r-')
xlabel('Time (ms)', 'FontSize', 25)
ylabel('Firing Rate', 'FontSize', 25)
title('Single Neuron Activity with Time', 'FontSize', 25)
legend('Firing Rate','Amplitude','Wavelength', 'FontSize', 20)

end