%% Lab1 ET

r0 = 4.5e-3;
h1 = 7e-2;
d = 4e-2;
a = 36e-2;
w = 58e-2;

%% Dimensionamento
% b)
K = 1/(2*pi) * [log(2*h1/r0)     log((2*h1+d)/d); 
			    log((2*h1 + d)/d) log(2*(h1+d)/r0)]

% c)
Kinv = inv(K)

%% Experimental
l = ; % Altura da água
% 5.1
I = ;
U = ;
o_exp = a/(w*l) * I/U

% 5.2 e 5.3
I1 = ;
U_I1 = [; ]; % Tensão U1exp e U2exp do primeiro ensaio
I2 = ;
U_I2 = [; ]; % Tensão U1exp e U2exp do segundo ensaio
Rexp = [U_I1/I1  U_I2/I2] 

Rteo = 1/(o_exp*l) * K;
Uteo = [Rteo*[I1; 0] Rteo*[0; I2]]'

avg = (Rexp(1,2) + Rexp(2,1))/2;
Rexp_corr = [ Rexp(1,1) ; avg
              avg       ;  Rexp(2,2) ]
Gexp_corr = inv(Rexp_corr)

% 5.4
I_exp = ; % Supostamente 5mA
G = Gexp_corr;
I1_prev = (G(1,1)+G(1,2)) / (G(1,1)+G(1,2)+G(2,1)+G(2,2)) * I_exp;
I2_prev = (G(2,1)+G(2,2)) / (G(1,1)+G(1,2)+G(2,1)+G(2,2)) * I_exp;
U = G \ [I1_prev; I2_prev];

% 5.5
I1 = ;
U_I1 = [; ]; % Tensão U1exp e U2exp do primeiro ensaio
I2 = ;
U_I2 = [; ]; % Tensão U1exp e U2exp do segundo ensaio
Rexp = [U_I1/I1  U_I2/I2] 
avg = (Rexp(1,2) + Rexp(2,1))/2;
Rexp_corr = [ Rexp(1,1) ; avg
              avg       ;  Rexp(2,2) ];
Gexp_corr = inv(Rexp_corr)
C = epsilon0/o_exp * Gexp_corr