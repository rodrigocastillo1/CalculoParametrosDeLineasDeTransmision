function DMG = getDMG(MatCoordCables)
%   Cálculo de la DMG entre conductores de una línea en metros.
%   getDMG(num_cables, MatCoordCables, conf)
%
%   PARÁMETROS:
%    > MatCoordCables: Matríz que indica las coordenadas de los cables de
%      cada conductor. Ejemplo: |  (0 0) (0 2)   (0 3)   |  -> Conductor A
%                               |  (2 1) (2 3)   (2 4)   |  -> Conductor B
%                               |  (4 2) (4 4) (inf inf) |  -> Conductor C
%    NOTA: Si alguna de las coordenadas es inf, significa que ese cable no
%    existe.
Coord_X = [];
Coord_Y = [];
[num_cond, num_cables] = size(MatCoordCables);
num_cables = num_cables/2;      %Cada cable tiene coordenada x e y 

for i = 1:2:num_cables*2        %Separamos coordenadas en X e Y
    Coord_X = [Coord_X, MatCoordCables(1:num_cond, i)];
    Coord_Y = [Coord_Y, MatCoordCables(1:num_cond, i+1)];
end

% Se calculan las coordenadas medias para cada conductor
k_x = 0; k_y = 0;
suma_x = 0; suma_y = 0;
X_prom = []; Y_prom = [];
for i = 1:num_cond
    for j = 1:num_cables
        if Coord_X(i,j) ~= inf
            suma_x = suma_x + Coord_X(i,j);
            k_x = k_x+1;
        end
        if Coord_Y(i,j) ~= inf
            suma_y = suma_y + Coord_Y(i,j);
            k_y = k_y+1;
        end
    end
    X_prom = [X_prom ; suma_x/k_x];
    Y_prom = [Y_prom ; suma_y/k_y];
    suma_x = 0; suma_y = 0;
    k_x = 0; k_y = 0;
end

DMG = Y_prom;