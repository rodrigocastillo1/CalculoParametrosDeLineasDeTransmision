%Programa que calcula los niveles de tensión y corriente de la línea en
%el extremo transmisor de la línea, utilizando los parámetros de la línea
%media.

function LM = line_Medium(V_op, I_op, Z, Y)
    a = 1 + (Z*Y/2);
    c = Y*(1 + (Z*Y/4));
    LM = lineMatrix(a, Z, c, a, V_op, I_op);