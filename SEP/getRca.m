
function R_ca = getRca(long, secc_trans, num_hilos)
%   Cálculo de la resistencia de CA de un conductor trenzado de ALUMINIO
%   getRca(long, secc_trans, num_hilos)
%
%   PARÁMETROS:
%    > long: Longitud del conductor en ft
%    > secc_trans: Sección transversal del conductor en cmil
%    > num_hilos: Número de hilos del conductor para calcular factor de
%      trenzado
Resistividad = 17; %(Ohm*cmil)/ft

r1 = Resistividad*long/secc_trans;
if num_hilos > 3
   r1 = r1 + r1*0.05;
else
   r1 = r1 + r1*0.04;
end

R_ca = r1;