%% Dimensionamento
% 1. a)
L = 0.2;
R = 700;
w = 2*pi*5e3;
alfa = -pi/2;
Uef = 2;

Z = sqrt(R^2 + (w*L)^2);
argZ = atan2(w*L, R);
phi = argZ
rad2deg(phi)
I = -sqrt(2)*Uef/Z * cos(alfa - argZ)
tau = L/R

%{
t = 0 : 1e-6: 1e-3;
h = figure('renderer','painters','pos',[0 0 800 600])
hold on;
grid on;
plot(t, (sqrt(2)*Uef/Z)*(cos(w.*t+alfa-phi) - cos(alfa - phi)*exp(-1*(t/tau))));
plot(t, sqrt(2)*Uef/Z*cos(w*t+alfa-phi));
plot(t, I*exp(-1*t/tau));
xlabel('t [s]');
ylabel('i(t) [A]');
title('Regime transitório do circuito RL série (relativo à corrente i)');
legend('i(t) = i_l(t) + i_f(t)', 'i_f(t)', 'i_l(t)');
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
print(h,'rl','-dpdf','-r0');
%}

% 1. b)
%{
k = -2
I0 = (sqrt(2)*Uef/Z * cos(-pi/2 + 2*k*pi - phi))/(exp(-1*(-pi/2 + 2*k*pi - alfa)/(w*tau)))
k = 0
I0 = (sqrt(2)*Uef/Z * cos(-pi/2 + 2*k*pi - phi))/(exp(-1*(-pi/2 + 2*k*pi - alfa)/(w*tau)))
k = -1e9
I0 = (sqrt(2)*Uef/Z * cos(-pi/2 + 2*k*pi - phi))/(exp(-1*(-pi/2 + 2*k*pi - alfa)/(w*tau)))
%}

% 1. c)
for k = [0 1 2 3 4]
    k
    text = (k*pi-alfa+phi)/w
    Iext = sqrt(2)*Uef/Z * ((-1)^k - cos(alfa - phi)*exp(-text/tau))
end