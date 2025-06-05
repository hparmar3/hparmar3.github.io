function [x_opt, z_opt, y_opt] = dual_simplex(A, b, c)
    % DUAL_SIMPLEX Solves the linear program using the Dual Simplex method:
    %   min c'x
    %   s.t. Ax = b, x >= 0
    %
    % Inputs:
    %   A - Constraint matrix (m x n, slack variables)
    %   b - RHS vector (m x 1)
    %   c - Cost vector (n x 1)
    % Outputs:
    %   x_opt - Optimal solution vector
    %   z_opt - Optimal objective function value
    %   y_opt - Optimal dual solution vector

    [m, n] = size(A); % Number of constraints (m) and variables (n)

    % Convert constraints to standard form by introducing slack variables
    % zeros to c
    c = [c, zeros(m, 1)'];

    % Construct the initial tableau with slack variables
    tableau = [A, b; c, 0];
    [~, n_2] = size(tableau);
    
    % Initialize the basis with slack variables
    basis = n_2-m:n;
    
    fprintf('Initial Tableau:\n');
    disp(tableau);
    
    % Dual simplex iteration loop
    while any(tableau(1:end-1, end) < 0)
        % Identify the leaving variable (most negative RHS value)
        [~, leaving] = min(tableau(end-1, 1:end-1));
        column = tableau(1:end-1, leaving);
        
        % Compute ratios to determine entering variable
        ratios = column(1:m) ./ tableau(1:m, end);
        [~, entering] = max(ratios);
        
        % Check for infeasibility
        if all(isinf(ratios))
            error('Problem is infeasible.');
        end
        
        % Perform pivot operation
        pivot = tableau(leaving, entering);
        tableau(leaving, :) = tableau(leaving, :) / pivot;
        
        % Update the rest of the tableau
        for i = 1:m+1
            if i ~= leaving
                tableau(i, :) = tableau(i, :) - tableau(i, entering) * tableau(leaving, :);
            end
        end
        
        % Update the basis
        basis(leaving) = entering;
        
        fprintf('Updated Tableau:\n');
        disp(tableau);
    end
    
    % Extract optimal solution
    x_opt = zeros(n-m, 1);
    x_opt(basis(basis <= n)) = tableau(1:m, end);
    
    % Extract optimal objective value
    z_opt = tableau(end, end);
    
    % Extract optimal dual solution
    y_opt = tableau(end, n_2-m:n)';
    
    % Display results
    fprintf('Optimal Solution: x = \n');
    disp(x_opt(1:n-m)); % Only primal variables, exclude slack variables
    fprintf('Optimal Value: z = %f\n', z_opt);
    fprintf('Optimal Dual Solution: y = \n');
    disp(y_opt);
end
