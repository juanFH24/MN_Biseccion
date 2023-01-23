clc;clear;close all

%Metodo numerico de la biseccion
%Autor= Juan Felipe Hernandez Arango. Ing.Quimico

%Parametros iniciales del metodo
Error=1;
tol=1e-6;
contador=1;

% valores inciales que encierran la raiz
xl=12;   xu=20;

[solucion,Error,contador]=Biseccion(xl,xu,tol,Error,contador)



% Se debe colocar a continuacion la funcion a solucionar igualada a 0 
% junto con los parametros necesarios para solucionar la funcion 
function [y]= Ecuacion (x)
g=9.8;
m=68.1;
t=10;
v=40;

y=((g*m)/x)*(1-exp(-(x/m)*t))-v;

end

% Metodo de la biseccion 
function [xr,Error,contador] = Biseccion(xl,xu,tol,Error,contador)

while Error>tol
 % Tal como establece el metodo, se reduce el intervalo a la mitad
    xr= (xl+xu)/2;
 % se evalua la funcion 
    fxl=Ecuacion (xl);
    fxr=Ecuacion (xr);
 %Cambio de limites
    if fxl*fxr<0
        xe=xu;
        xu=xr;
        contador=contador+1;
        Error=abs((xr-xe)/xr);
    elseif fxr*fxl>0 
        xe=xl;
        xl=xr;
        contador=contador+1;
        Error=abs((xr-xe)/xr);
    else
        break
    end 
 end
end

