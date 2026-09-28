cl c; clear; close all;

E = 3e9;              % Young's Modulus (Pa)
width = 0.5;          % Paper width (m)
thickness = 0.0001;   % Paper thickness (m)
A = width * thickness;
L = 0.2;              % Distance between rollers (m)
V1 = 1.0;             % Upstream roller speed (m/s)
V2 = 1.1;             % Downstream roller speed (m/s)

%% Effective Stiffness

K = (E*A)/L;

fprintf('Effective Stiffness K = %.2f\n',K);

%% Time Settings

dt = 0.01;

t = 0:dt:10;

%% ==========================================
% CASE 1 : BASIC TENSION RESPONSE
%% ==========================================

c = 0.5;      % damping coefficient

T = zeros(size(t));

for i = 2:length(t)

    dTdt = K*(V2-V1)*1e-6 - c*T(i-1);

    T(i) = T(i-1) + dTdt*dt;

end

figure;

plot(t,T,'LineWidth',2)

xlabel('Time (s)')
ylabel('Tension (N)')
title('Basic Tension Response')
grid on

%% ==========================================
% CASE 2 : EFFECT OF ROLLER SPEED
%% ==========================================

speed_cases = [1.1 1.2 1.3];

figure;

hold on

for j = 1:length(speed_cases)

    V2 = speed_cases(j);

    T = zeros(size(t));

    for i = 2:length(t)

        dTdt = K*(V2-V1)*1e-6 - c*T(i-1);

        T(i) = T(i-1) + dTdt*dt;

    end

    plot(t,T,'LineWidth',2)

end

xlabel('Time (s)')
ylabel('Tension (N)')

title('Effect of Roller Speed on Tension')

legend('V2 = 1.1 m/s',...
       'V2 = 1.2 m/s',...
       'V2 = 1.3 m/s')

grid on

%% ==========================================
% CASE 3 : DISTURBANCE AT 5 SECONDS
%% ==========================================

T = zeros(size(t));

for i = 2:length(t)

    if t(i) < 5

        V2 = 1.1;

    else

        V2 = 1.3;

    end

    dTdt = K*(V2-V1)*1e-6 - c*T(i-1);

    T(i) = T(i-1) + dTdt*dt;

end

figure;

plot(t,T,'LineWidth',2)

xlabel('Time (s)')
ylabel('Tension (N)')

title('Tension Response to Speed Disturbance')

grid on

%% ==========================================
% SAVE LAST GRAPH
%% ==========================================

saveas(gcf,'Disturbance_Response.png')

fprintf('Simulation Complete.\n');