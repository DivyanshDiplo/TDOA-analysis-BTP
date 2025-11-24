clear; clc; close all;

% Configure receiver positions & filenames
% RX and Ref TX Position
rx1_lat = 49.441781; % RX 1
rx1_long = 7.767362;

rx2_lat = 49.422394; % RX 2
rx2_long = 7.739099;
file_identifier = 'yourfilename'; % as appropriate

dateiname1 = ['recorded_data/1_' file_identifier];
dateiname2 = ['recorded_data/2_' file_identifier];

% (Optional: add your parameters here)
sample_rate = 2e6;  % [Hz]

% --- Read IQ signals ---
signal1 = read_file_iq(dateiname1);
signal2 = read_file_iq(dateiname2);

% --- Compute TDOA ---
% Dummy variables, adapt as needed:
rx_distance_diff12 = 0;  % Leave zero if you do not calibrate to reference TX
rx_distance12 = dist_latlong(rx1_lat, rx1_long, rx2_lat, rx2_long, mean([rx1_lat, rx2_lat]), mean([rx1_long, rx2_long]));

% Your settings for tdoa2 arguments (set as needed)
smoothing_factor = 0;
corr_type = 'abs';
signal_bandwidth_khz = 0;
ref_bandwidth_khz = 0;
smoothing_factor_ref = 0;
interpol_factor = 0;

report_level = 1;

[doa_meters12, doa_samples12, reliability12] = tdoa2(signal1, signal2, rx_distance_diff12, rx_distance12, ...
    smoothing_factor, corr_type, report_level, signal_bandwidth_khz, ...
    ref_bandwidth_khz, smoothing_factor_ref, interpol_factor);

% --- Generate Locus/Hyperbola ---
[points_lat, points_long] = gen_hyperbola(doa_meters12, rx1_lat, rx1_long, rx2_lat, rx2_long, ...
    mean([rx1_lat, rx2_lat]), mean([rx1_long, rx2_long]));

% --- Plot the hyperbola locus directly on a map ---
figure;
plot(points_long, points_lat, 'b-', 'LineWidth', 2); hold on;
plot(rx1_long, rx1_lat, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
plot(rx2_long, rx2_lat, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
xlabel('Longitude');
ylabel('Latitude');
title('TDOA transmitter locus from 2 receivers');
legend('TDOA hyperbola', 'Receiver 1', 'Receiver 2');
grid on;
axis equal;
