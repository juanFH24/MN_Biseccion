clc;clear;close all

%Metodo numerico de brent
%Autor= Juan Felipe Hernandez Arango. Ing.Quimico

%Parametros iniciales del metodo
tol= 1e-6;
Error=1;
contador=0;

% valores incial para el metodo cerrado
a=12;
b=20;

[solucion,Error,contador]=Brent(a,b,tol,Error,contador)

% Se debe colocar a continuacion la funcion a solucionar igualada a 0 
% junto con los parametros necesarios para solucionar la funcion 
function [y]= f (x)
g=9.8;
m=68.1;
t=10;
v=40;

y=((g*m)/x)*(1-exp(-(x/m)*t))-v;


end


% Metodo de brent
function [xr,Error,contador] =Brent(a,b,tol,Error,contador)
% se evalua la funcion en el primer valor y se verifica que sea la solucion
x1= a; f1=f(x1);
if f1==0 
    xr=x1;
    return
end
% se evalua la funcion en el segundo valor y se verifica que sea la solucion
x2=b; f2=f(x2);
if f2==0
    xr=x2;
    return
end
%comprobacion
if f1*f2>0
    error('la raiz no se encuentra en el intervalo')
end
%metodo de la biseccion 
x3=(a+b)/2;
while Error>tol
    f3=f(x3);
    if abs(f3)<tol
        xr=x3;
        return
    end
    if f1*f3 <0
        b=x3;
    else
        a=x3;
    end
    if (b-a)<tol*max(abs(b),1)
        xr=(a+b)/2;
        return
    end
    %Metodo de interpolacion cuadratica inversa
    denominador=(f2-f1)*(f3-f1)*(f2-f3);
    numerador=x3*(f1-f2)*(f2-f3+f1)+f2*x1*(f2-f3)+f1*x2*(f3-f1);
    if denominador==0
        dx=b-a;
    else
        dx=f3*numerador/denominador;
    end
    x=x3+dx;
    if (b-x)*(x-a)<0
        dx=0.5*(b-a);
        x=a+dx;
    end
    if x<x3
        x2=x3; f2=f3;
    else
        x1=x3; f1=f3;
    end
    x3=x;
    contador=contador+1;
    
end
end



function [xr,Error,contador] =Brentl(a,b,tol,Error,contador) 

if abs(f(a))<abs(f(b))
    auxiliar=a;
    a=b;
    b=auxiliar;
end
c=a;
mflag=1;

while Error>tol
Error=abs(b-a);

if f(a)~=f(c) && f(b)~=f(c)
    %Metodo de interpolacion cuadratica inversa
    x2=(a*f(b)*f(c))/((f(a)-f(b))*(f(a)-f(c)))+(b*f(a)*f(c))/((f(b)-f(a))*(f(b)-f(c)))+(c*f(a)*f(b))/((f(c)-f(a))*(f(c)-f(b)));
else
    %Metodo de la secante
    x2=(a*f(b)-b*f(a))/(f(b)-f(a));
end

if ((x2<(3*x2+b)/4) || x2>b) || ...
   (mflag==1 &&(abs(x2-b))>=(abs(b-c)/2)) || ...
   (mflag==0 &&(abs(x2-b))>=(abs(c-d)/2)) || ...
   (mflag==1 &&(abs(b-c))<tol) || ...
   (mflag==0 &&(abs(b-d))<tol)

    x2=(a+b)/2;  %metodo de la biseccion
    mflag=1;
else
    mflag=0;
    d=c; c=b;
end

if f(a)*f(x2)<0
    b=x2;
else
    a=x2;
 
if abs(f(a))<abs(f(b))
    auxiliar=a;
    a=b;
    b=auxiliar;
end
end
contador=contador+1;
end
xr=x2;
end