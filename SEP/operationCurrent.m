%Programa que calcula el valor de la corriente en la terminar de recepción
%de la línea de transmisión, dependiendo de la potencia que consume y su
%factor de potencia


function I_r = operationCurrent(V, P, fp)
    
    I = P/(abs(fp)*(V/sqrt(3)));
    ang = acosd(abs(fp));
    sign = fp/abs(fp);
    re = I*cos(ang);
    im = I*sin(ang);
    I_r = re + im*fp/abs(fp)*i;
    
    