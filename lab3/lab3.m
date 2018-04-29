%% Dimensionamento
%{
f0 = 40e3;
w0 = 2*pi*f0;
L = 2e-3;
Rs1 = 250;
Rs2 = 500;
fn = 10e3/f0 : 0.01 : 90e3/f0;

function y = Q0 (Rs, w0, L)
  y = w0 * L / Rs;
end

function y = In (fn, Rs, w0, L)
  y = 1./sqrt(1 + Q0(Rs, w0, L)^2 * (fn - 1./fn).^2);
end

figure;
plot(fn, In(fn, Rs1, w0, L));
title('Rs = 250 \Omega', 'interpreter', 'tex');
figure;
plot(fn, In(fn, Rs2, w0, L));
title('Rs = 500 \Omega', 'interpreter', 'tex');

C = 1/(w0^2 * L);

function y = Z(R, w, L, C)
	y = sqrt(R^2 + (w*L - 1/(w*C))^2);
endfunction

function y = alfaZ(R, w, L, C)
	y = atan2(w*L - 1/(w*C), R);
endfunction	

function y = Ief(Rs, w, L, C)
	y = 1 / Z(Rs, w, L, C); % Ug = 1 V sempre
endfunction

function y = alfaI(Rs, w, L, C)
	y = - alfaZ(Rs, w, L, C);
endfunction	

function y = Ucef(Rs, w, L, C)
	y = Ief(Rs, w, L, C) / (w*C);
endfunction	

function y = alfaUc(Rs, w, L, C)
	y = alfaI(Rs, w, L, C) - (pi/2);
endfunction	

function y = Ulef(Rs, w, L, C)
	y = Ief(Rs, w, L, C) * w*L;
endfunction	

function y = alfaUl(Rs, w, L, C)
	y = alfaI(Rs, w, L, C) + (pi/2);
endfunction	

function y = Uref(Rs, w, L, C)
	y = Ief(Rs, w, L, C) * Rs;
endfunction	

function y = alfaUr(Rs, w, L, C)
	y = alfaI(Rs, w, L, C);
endfunction	

for f = [f0 0.95*f0 1.05*f0]
	f	
	w = 2*pi*f;
	printf("Ief = %f ∠ %f\n", Ief(Rs1, w, L, C), rad2deg(alfaI(Rs1, w, L, C)));
	printf("Ucef = %f ∠ %f\n", Ucef(Rs1, w, L, C), rad2deg(alfaUc(Rs1, w, L, C)));
	printf("Ulef = %f ∠ %f\n", Ulef(Rs1, w, L, C), rad2deg(alfaUl(Rs1, w, L, C)));
	printf("Uref = %f ∠ %f\n", Uref(Rs1, w, L, C), rad2deg(alfaUr(Rs1, w, L, C)));
	disp('');
endfor
%}
%% Experimental
% 5.1/6.1
disp('5.1');
f = [ 1; 2; 3; ];
Cexp = [ 5; 6; 7; ];
x = Cexp;
y = 1./(f.^2);
figure;
plot(x, y, 'rx');
hold on;

% Number of sample points
n = length(x);
% https://en.wikipedia.org/wiki/Ordinary_least_squares#Simple_regression_model
%m = (n*sum(x.*y) - (sum(x)*sum(y)))/(n*sum(x.^2) - sum(x)^2)
%b = (1/n)*sum(y) - m*(1/n)*sum(x)

% Add a column of all ones (intercept term) to x
X = [ones(n, 1) x];
% Calculate the normal equation of OLS https://en.wikipedia.org/wiki/Ordinary_least_squares
% http://www.lauradhamilton.com/tutorial-linear-regression-with-octave
%R = (pinv(X'*X))*X'*y
% https://octave.org/doc/v4.2.2/Linear-Least-Squares.html
R = ols(y, X);
plot(x, X*R);
m = R(2)
b = R(1)
L = m/(4*pi^2)
Cd = b/(4*pi^2*L)

% 5.2 a) / 6.2
disp('5.2 a)');
Cexp = ;
%fexp = [f0 0.95*f0 1.05*f0];
fexp = [ ];
delta_t = [ ];
for f = fexp
	f
	w = 2*pi*f;
	%alfaI = w * delta_t
	printf("Ief = %f ∠ %f\n", Ief(Rs1, w, L, C), rad2deg(alfaI(Rs1, w, L, C)));
	disp('');
endfor

% 5.2 b) / 6.3

