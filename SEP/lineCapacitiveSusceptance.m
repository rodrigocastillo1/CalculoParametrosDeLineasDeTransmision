%La función lineCapacitiveSusceptance calcula la susceptancia capacitiva
%total por fase de una línea de transmisión de CA en Ohms. Para el cálculo
%debe recibir como parámetros de entrada:
%- La frecuencia de operación de la línea en Hz
%- La longitud total de la línea en km
%- El diámetro medio geométrico del arreglo en m
%- El radio medio geométrico del conductor en m

function BC_L = lineCapacitiveSusceptance(f, d, DMG_C, RMG_C)
    c = (2*pi*(8.85*10^(-12)))/(log(DMG_C/RMG_C));  %capacitancia por unidad de longitud en F/m
    C = c*d*1000;                                   %capacitancia de la línea total en F
    BC_L = 2*pi*f*C;                                %Susceptancia de la línea en Ohms