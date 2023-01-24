clc;clear;close all

%Metodo numerico de NewtonRaphson derivada analitica
%Autor= Juan Felipe Hernandez Arango. Ing.Quimico

%Parametros iniciales del metodo
Error=1;
tol=1e-6;
contador=0;

% valores incial para el metodo abierto
xr=12;   

[solucion,Error,contador]=NewtonRapshon(xr,tol,Error,contador)



% Se debe colocar a continuacion la funcion a solucionar igualada a 0 
% junto con los parametros necesarios para solucionar la funcion 
function [y]= Ecuacion (x)
g=9.8;
m=68.1;
t=10;
v=40;

y=((g*m)/x)*(1-exp(-(x/m)*t))-v;

end

% En esta funcion debe ir la derivada analitica junto con los parametros
% necesarios
function [y]= derivada (x)
g=9.8;
m=68.1;
t=10;
v=40;

y=(-g*m*(m*exp(x*t/m)-x*t-m)*exp(-x*t/m))/(m*x^2);

end

% Metodo de Newton Rapshon con derivada analitica
function [xr,Error,contador] = NewtonRapshon(xr,tol,Error,contador)

while Error>tol
    % se aplica la formula de Newton Rapshon para aproximarce a la raiz

    xsol=xr-(Ecuacion(xr)/derivada(xr));

    Error=abs((xsol-xr)/xsol);     % se calcula el error relativo
    contador=1+contador;
    xr=xsol;
  
 end
end
