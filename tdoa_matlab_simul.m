% Reproducibility
rng(2021);

% 3 receivers in a 2-D scenario with 1 moving emitter
numReceivers = 3;
[scenario, rxPairs] = helperCreateSingleTargetTDOAScenario(numReceivers);

% TDOA accuracy: variance in ns^2 (e.g., 100 ns std)
measNoise = (100)^2;

% Advance once and simulate TDOAs
advance(scenario);
tdoaDets = helperSimulateTDOA(scenario, rxPairs, measNoise);  % cell of objectDetection

% Optionally read global units
gp = helperGetGlobalParameters;  % gp.EmissionSpeed, gp.TimeScale (ns <-> s)

% Convert TDOAs (ns) to seconds for inspection
tdoa_sec = cellfun(@(d) d.Measurement / gp.TimeScale, tdoaDets);

% Estimate position (uses spherical intersection), Z will be near 0 for 2-D
[pos3, posCov] = helperTDOA2Pos(tdoaDets);   % pos3 = [x;y;z]
pos2 = pos3(1:2);
