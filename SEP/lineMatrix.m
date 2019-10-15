%Programa que realiza el cálculo de voltaje y corriente de las terminales
%de generación de la línea de transmisión. Este recibe como parámetros: Los
%valores de la matriz, como A, B, C y D, el nivel de tensión y corriente en
%la terminal de recepción.

function T = lineMatrix(A, B, C, D, V_r, I_r)
    M = [A B; C D];
    R = [V_r; I_r];
    
    T = M*R;
    