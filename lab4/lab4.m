%% Dimensionamento
% 1. a)
L = 0.2;
R = 700;
w = 2*pi*5e3;
alfa = -pi/2;
Uef = 2;
tau = L/R;

Z = sqrt(R^2 + (w*L)^2)
argZ = atan2(w*L, R)
phi = argZ
rad2deg(phi)
I = -sqrt(2)*Uef/Z * cos(alfa - argZ)

t = 0 : 1e-6: 1e-3;
%h = figure('renderer','painters','pos',[0 0 800 600])
figure;
hold on;
plot(t, (sqrt(2)*Uef/Z)*(cos(w.*t+alfa-phi) - cos(alfa - phi)*exp(-1*(t/tau))));
plot(t, sqrt(2)*Uef/Z*cos(w*t+alfa-phi));
plot(t, I*exp(-1*t/tau));
xlabel('t [s]');
ylabel('i(t) [A]');
title('Regime transitório do circuito RL (relativo à corrente i)');
legend('i(t) = i_l(t) + i_f(t)', 'i_f(t)', 'i_l(t)');
%set(h,'Units','Inches');
%pos = get(h,'Position');
%set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
%print(h,'rl','-dpdf','-r0');

% 1. b)
k = 1
I0 = (sqrt(2)*Uef/Z * cos(-pi/2 + 2*k*pi - phi))/(exp(-1*(-pi/2 + 2*k*pi - alfa)/w*tau))
