a = 2000; % Side of equilateral triangle

% Receiver coordinates
R1 = [0, 0];
R2 = [a, 0];
R3 = [a/2, a*sqrt(3)/2];

% Transmitter (centroid calculation)
Tx = [a/3, a*sqrt(3)/6];

figure;
hold on;

% Plot triangle connecting receivers
plot([R1(1), R2(1), R3(1), R1(1)], [R1(2), R2(2), R3(2), R1(2)], 'ko--','LineWidth',2);

% Plot receivers
plot(R1(1), R1(2), 'ro', 'MarkerSize', 12, 'LineWidth',2, 'DisplayName', 'Receiver 1');
plot(R2(1), R2(2), 'go', 'MarkerSize', 12, 'LineWidth',2, 'DisplayName', 'Receiver 2');
plot(R3(1), R3(2), 'bo', 'MarkerSize', 12, 'LineWidth',2, 'DisplayName', 'Receiver 3');

% Plot transmitter
plot(Tx(1), Tx(2), 'kp', 'MarkerSize', 14, 'MarkerFaceColor', 'y', 'DisplayName', 'Transmitter');

legend('Receivers Triangle','Receiver 1','Receiver 2','Receiver 3','Transmitter');
xlabel('X (meters)');
ylabel('Y (meters)');
title('Receiver and Transmitter Geometry');
axis equal; grid on;
hold off;
