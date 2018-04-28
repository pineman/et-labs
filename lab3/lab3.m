f0 = 40e3;
w0 = 2*pi*f0;
L = 2e-3;
Rs1 = 250;
Rs2 = 500;
fn = 10e3/f0 : 0.01 : 90e3/f0;

%function y = Q0 (Rs, w0, L)
%  y = w0 * L / Rs;
%end
%
%function y = In (fn, Rs, w0, L)
%  y = 1./sqrt(1 + Q0(Rs, w0, L)^2 * (fn - 1./fn).^2);
%end
%
%figure("Name", "1");
%plot(fn, In(fn, Rs1, w0, L));
%figure("Name", "2");
%plot(fn, In(fn, Rs2, w0, L));

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

for w = 2*pi*[f0 0.95*f0 1.05*f0]
	f = w/(2*pi)
	printf("Ief = %g ∠ %g\n", Ief(Rs1, w, L, C), rad2deg(alfaI(Rs1, w, L, C)));
	printf("Ucef = %g ∠ %g\n", Ucef(Rs1, w, L, C), rad2deg(alfaUc(Rs1, w, L, C)));
	printf("Ulef = %g ∠ %g\n", Ulef(Rs1, w, L, C), rad2deg(alfaUl(Rs1, w, L, C)));
	printf("Uref = %g ∠ %g\n", Uref(Rs1, w, L, C), rad2deg(alfaUr(Rs1, w, L, C)));
	disp('');
endfor