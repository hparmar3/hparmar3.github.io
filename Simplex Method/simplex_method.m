function[x_opt, z_opt] = simplex_method(A, b, c)
    % SIMPLEX_METHOD Solves the linear program:
    % Inputs:
    % A - Constraint matrix (m x n)
    % b - RHS vector (m x 1)
    % c - Cost vector (n x 1)
    % Outputs:
    % x_opt - Optimal solution vector
    % z_opt - Optimal objective function value

    [m, n] = size(A); % m: number of constraints, n: number of variables
    B = (n - m + 1):n; % Identify basic variables (columns forming identity matrix)
    N = setdiff(1:n, B); % Identify non-basic varaibles

    % Construct initial tableau
    tableau = [A b; -c' 0];
    fprintf('Initial Tableau:\n');
    disp(tableau);

    iter = 0;
    while true
        iter = iter + 1;
        fprintf('Iteration %d:\n', iter);

        % Extract the last row (cost row)
        z_row = tableau(end, 1:end-1);

        % Check optimality: If all z coefficients are >= 0, optimal
        % solution found
        if all(z_row(N) >= 0)
            fprintf('Optimal solution found.\n');
            break;
        end

        % Bland's Rule: Choose entering variable with smallest index
        entering = N(find(z_row(N) < 0, 1));

        % Compute minimum ratio test to determine the leaving variable
        ratios = tableau(1:m, end) ./ tableau(1:m, entering);
        ratios(tableau(1:m, entering) <= 0) = inf; % Ignore negative or zero ratios

        if all(ratios == inf)
            error('Unbounded problem! No feasible solution.');
        end

        % Choose the leaving variable (smallest ratio, Bland's rule for
        % ties)
        [~, leaving_idx] = min(ratios);
        leaving = B(leaving_idx);

        % Pivot operation
        pivot_row = tableau(leaving_idx, :) / tableau(leaving_idx, entering);
        for i = 1:m+1
            if i ~= leaving_idx
                tableau(i, :) = tableau(i, :) - tableau(i, entering) * pivot_row;
            end
        end
        tableau(leaving_idx, :) = pivot_row;

        % Update basis
        B(leaving_idx) = entering;
        N = setdiff(1:n, B);

        % Display updated tableau
        fprintf('Updated Tableau:\n')
        disp(tableau);

        % Display current basic feasible solution
        x_B = tableau(1:m, end);
        x = zeros(n, 1);
        x(B) = x_B;
        fprintf('Current Basic Feasible Solution:\n');
        disp(x');
    end

    % Extract optimal solution and objective value
    x_opt = zeros(n, 1);
    x_opt(B) = tableau(1:m, end);
    z_opt = tableau(end, end);

    fprintf('Optimal Solution x*:\n');
    disp(x_opt);
    fprintf('Optimal Objective Function Value:\n');
    disp(z_opt);

end
