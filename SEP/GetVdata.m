function Vmag_pu = GetVdata(VmagNodos, Vbase)

    VmagNodos = VmagNodos./Vbase;

%     a = size(VmagNodos);
%     Vdato = zeros(a(1), 1);
%     for j = 1:a(1)
%         if isnan(VmagNodos(j))                      % Si la magnitud del nodo no es conocida (tampoco se conoce el ángulo):
%             Vdato(j) = inf + 1i*inf;                % Se designa el Vdato de este nodo como infinito
%         else
%             Vdato(j) = VmagNodos(j) + 1i*VmagNodos(j).*sin(VangNodos(j));   % Sino
%         end
%     end

end