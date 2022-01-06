% Loading the data
load('stored_data.mat', 'pow_in_arr');
load('stored_data.mat', 'pow_out_mat');
load('stored_data.mat', 'pow_in');
load('stored_data.mat', 'deembed');
load('stored_data.mat', 'pow_out_mat_de');

figure(1);

% Input Power vs. Amplifier Gain Graphs
subplot(2,3,1);
plot(pow_in_arr, pow_out_mat_de(1,:))
title('Input Power vs. Amplifier Gain (at 500 MHz)')
xlabel('Input Power [dBm]')
ylabel('Amplifier Gain [dB]')

subplot(2,3,2);
plot(pow_in_arr, pow_out_mat_de(2,:))
title('Input Power vs. Amplifier Gain (at 1 GHz)')
xlabel('Input Power [dBm]')
ylabel('Amplifier Gain [dB]')

subplot(2,3,3);
plot(pow_in_arr, pow_out_mat_de(3,:))
title('Input Power vs. Amplifier Gain (at 1.5 GHz)')
xlabel('Input Power [dBm]')
ylabel('Amplifier Gain [dB]')

subplot(2,3,4);
plot(pow_in_arr, pow_out_mat_de(4,:))
title('Input Power vs. Amplifier Gain (at 2 GHz)')
xlabel('Input Power [dBm]')
ylabel('Amplifier Gain [dB]')

subplot(2,3,5);
plot(pow_in_arr, pow_out_mat_de(5,:))
title('Input Power vs. Amplifier Gain (at 2.5 GHz)')
xlabel('Input Power [dBm]')
ylabel('Amplifier Gain [dB]')

subplot(2,3,6);
plot(pow_in_arr, pow_out_mat_de(6,:))
title('Input Power vs. Amplifier Gain (at 3 GHz)')
xlabel('Input Power [dBm]')
ylabel('Amplifier Gain [dB]')


suptitle('RF - Amplifier Compression Measurements - Input Power vs. Amplifier Gain') 
