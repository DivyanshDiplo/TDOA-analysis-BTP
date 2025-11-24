%% Config File for TDOA setup

% RX and Ref TX Position
rx1_lat = 28.5451118; % RX 1
rx1_long = 77.1907636;

rx2_lat = 28.5451202; % RX 2
rx2_long = 77.1907669;

rx3_lat = 28.545199; % RX 3
rx3_long = 77.756599;

tx_ref_lat = 28.5451100; % Referenz: Rotenberg DAB
tx_ref_long = 77.71907611;


% IQ Data Files
file_identifier = 'test.dat';
folder_identifier = 'recorded_data/';


% signal processing parameters
signal_bandwidth_khz = 0;  % 400, 200, 40, 12, 0(no)
smoothing_factor = 0;
corr_type = 'dphase';  %'abs' or 'dphase'
interpol_factor = 0;

% additional processing of ref signal
%(set to > 0 only when other signals than the ref signal falls into the full RX bandwidth)
ref_bandwidth_khz = 0; % 400, 200, 40, 12, 0(no)
smoothing_factor_ref = 0;

% 0: no plots
% 1: show correlation plots
% 2: show also input spcetrograms and spectra of input meas
% 3: show also before and after filtering
report_level = 3;

% map output
% 'open_street_map' (default) or 'google_maps'
map_mode = 'open_street_map';

% heatmap (only with google maps)
heatmap_resolution = 400; % resolution for heatmap points
heatmap_threshold = 0.1;  % heatmap point with lower mag are suppressed for html output