%Metodo de Newton: Aplica o Metodo de Newton a uma função func
% enquanto a diferença entre o último termo da sucessão e a 
% aproximação inicial, aprox, for maior que um erro e.
%Parametros:
% func - função à qual vai ser aplicado o metodo de Newton
% func_der - derivada da função func
% aprox - aproximação inicial
% e - erro
function [x, dif_x] = metodo_newton(func, func_der, aprox, e)
    % primeiro termo da sucessão
    x = aprox + func(aprox)/func_der(aprox);
    %dif_ans é |lambda_n+1 - lambda_n|
    dif_x = abs(x(end) - aprox);
    %Gerar membros da sucessão enquanto a difença entre o ultimo
    %termo e a aprox for maior que e.
    while dif_x(end) > e
        %Gerar membro da sucessão
        x = [x (x(end) - func(x(end))/func_der(x(end)))];
        %Calcular a diferença entre o membro anterior e a aprox
        dif_x = [dif_x abs(x(end) - x(end - 1))];
    end

end
