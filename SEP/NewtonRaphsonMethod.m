function [IterationTable, VarList, Final_Values] = NewtonRaphsonMethod(EqVector, JacMatrix, SymsVarList, MaxNumIt, MaxError)
    max_it = MaxNumIt;      % Número máximo de iteraciones
    num_it = 0;             % Variable que controla el número de iteraciones ejecutadas
    max_error = MaxError;   % Error permitido en el cálculo para la convergencia
    error = 1;
    
    VarList = arrayfun(@char, SymsVarList, 'uniform', 0);   % Se convierten las variables simbólicas en cadenas
    InitialValues = 1*strncmp(VarList,'V',1);               % Se inicializan las variables de voltaje en 1 y las de ángulo en 0
    
    X = InitialValues';
    %Tabla = table(X);
    Iter_log = X;
    Error = inf;
    while error > max_error && num_it < max_it
        
        J = JacMatrix; g = EqVector;
        for j = 1:size(X)
            J = subs(J, SymsVarList(j), X(j));              % Se sustituyen las variables simbólicas por los valores nuevos de X 
            g = subs(g, SymsVarList(j), X(j));
        end
        J = double(J); g = double(g);

        old_X = X;
        X = X - pinv(J)*g;
        error = mean(abs(old_X - X));
        Iter_log = [Iter_log, double(X)];
        Error = [Error; error];
        num_it = num_it + 1;
    end
    
    Final_Values = double(X);
    Iter_log = Iter_log';
    Num_Iteracion = [0:num_it]'; 
    IterationTable = array2table(Iter_log,'VariableNames',VarList);
    IterationTable = [table(Num_Iteracion), IterationTable, table(Error)]; 
end