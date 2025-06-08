function [x_opt, z_opt] = two_phase_simplex(A, b, c)
    % TWO_PHASE_SIMPLEX Solves the LP:
    %    minimize   c'*x
    %    subject to A*x = b, x >= 0
    %
    % using the two-phase simplex method with Bland's rule and prints
    % the simplex tableau at each iteration.
    %
    % Inputs:
    %    A - Constraint matrix (m x n)
    %    b - RHS vector (m x 1)
    %    c - Cost vector (n x 1)
    %
    % Outputs:
    %    x_opt - Optimal solution vector (n x 1)
    %    z_opt - Optimal objective value

    [m, n] = size(A);
    
    % --- STEP 1: Ensure b is nonnegative ---
    for i = 1:m
        if b(i) < 0
            A(i, :) = -A(i, :);
            b(i) = -b(i);
        end
    end

    % --- PHASE 1: Add artificial variables ---
    % Construct Phase 1 LP: minimize sum(artificial) subject to A*x = b.
    % Our Phase 1 A is [A  I] and its cost is [zeros(n,1); ones(m,1)].
    A_phase1 = [A, eye(m)];
    c_phase1 = [zeros(n, 1); ones(m, 1)];
    
    fprintf('--- Starting Phase 1 ---\n');
    % Call simplex_method (Phase 1) and obtain the final tableau and basis.
    [~, z_phase1, tableau_phase1, basic_vars_phase1] = simplex_method(A_phase1, b, c_phase1, 1);
    
    % If the Phase 1 objective is not zero, the original LP is infeasible.
    if abs(z_phase1) > 1e-8
        error('Infeasible problem! Phase 1 optimal objective = %g', z_phase1);
    end
    
    % --- Prepare for Phase 2 ---
    % Remove the artificial variable columns.
    % The original variables are in columns 1:n.
    % Also, remove the artificial parts from the tableau.
    % Our tableau has m+1 rows and (n+m+1) columns; we want columns 1:n and the RHS.
    tableau_phase2 = tableau_phase1(:, [1:n, end]);
    
    % Reset the cost row to the original objective: [c'  0]
    tableau_phase2(end, :) = [c, 0];
    
    % Adjust the cost row using the current basis.
    % For each basic variable that is an original variable (<= n),
    % subtract c(basic)*that row.
    for i = 1:m
       if basic_vars_phase1(i) <= n
          tableau_phase2(end, :) = tableau_phase2(end, :) - c(basic_vars_phase1(i)) * tableau_phase2(i, :);
       end
    end
    
    fprintf('--- Starting Phase 2 ---\n');
    fprintf('Initial Phase 2 Tableau:\n');
    disp(tableau_phase2);
    
    % Now, solve Phase 2 starting from the current tableau and basis.
    [x_opt, z_opt, ~, ~] = simplex_method_given_basis(tableau_phase2, basic_vars_phase1, n);
    
    fprintf('--- Final Optimal Solution ---\n');
    disp(x_opt);
    fprintf('Optimal Objective Function Value: %g\n', -z_opt);
end


function [x_opt, z_opt, tableau, basic_vars] = simplex_method(A, b, c, phase)
    % SIMPLEX_METHOD Solves the LP in tableau form.
    % When phase==1, it sets up the tableau with artificial variables.
    %
    % Inputs:
    %    A, b, c : LP in standard form, where tableau is constructed as
    %              [A  b] with an extra row [c' 0].
    %    phase  : 1 for Phase 1; (if not 1, basic_vars is set arbitrarily)
    %
    % Outputs:
    %    x_opt      - optimal solution vector (for the tableau's variables)
    %    z_opt      - optimal objective value
    %    tableau    - final simplex tableau
    %    basic_vars - vector of indices (one per constraint) indicating the
    %                 column index of the basic variable in that row.
    
    [m, total_vars] = size(A);  % Note: A is m x (n_total) where n_total = n + (if phase1: m)
    n_total = total_vars;  % number of decision columns in the tableau (excluding RHS)
    
    % Construct the initial tableau.
    % The tableau has m constraint rows and one objective row.
    tableau = [A, b];        % m x (n_total+1)
    tableau = [tableau; [c', 0]];  % (m+1) x (n_total+1)
    
    % For Phase 1, the initial basic variables are the artificial ones.
    if phase == 1
        % Let the original LP have n = n_total - m variables.
        n_orig = n_total - m;
        basic_vars = (n_orig+1):(n_orig+m);
        % Now, adjust the objective row: for each row with a basic artificial
        % variable, subtract that row from the objective row.
        for i = 1:m
            tableau(end, :) = tableau(end, :) - tableau(i, :);
        end
    else
        % For non–Phase-1 (should not occur here), set basic_vars arbitrarily.
        basic_vars = 1:m;
    end

    fprintf('Initial Tableau (Phase %d):\n', phase);
    disp(tableau);
    
    tol = 1e-8;
    iter = 0;
    max_iter = 1000;
    
    while iter < max_iter
       iter = iter + 1;
       
       % --- Optimality test ---
       % (Look at the coefficients in the objective row, excluding RHS.)
       if all(tableau(end, 1:end-1) >= -tol)
           % Construct the solution vector.
           x_opt = zeros(n_total, 1);
           for i = 1:m
               if basic_vars(i) <= n_total
                   x_opt(basic_vars(i)) = tableau(i, end);
               end
           end
           z_opt = tableau(end, end);
           fprintf('Optimal tableau reached after %d iterations.\n', iter);
           return;
       end
       
       % --- Choose entering variable using Bland's Rule ---
       entering_candidates = find(tableau(end, 1:end-1) < -tol);
       entering_col = min(entering_candidates);  % smallest index
      
       % --- Check for unboundedness ---
       col = tableau(1:m, entering_col);
       if all(col <= tol)
           error('Linear program is unbounded.');
       end
       
       % --- Determine leaving variable using the minimum ratio test (with Bland tie-break) ---
       ratios = inf(m, 1);
       for i = 1:m
           if tableau(i, entering_col) > tol
              ratios(i) = tableau(i, end) / tableau(i, entering_col);
           end
       end
       min_ratio = min(ratios);
       leaving_candidates = find(abs(ratios - min_ratio) < tol);
       leaving_row = min(leaving_candidates);  % choose smallest index
      
       % --- Perform pivot ---
       tableau = pivot(tableau, entering_col, leaving_row);
       basic_vars(leaving_row) = entering_col;
       
       fprintf('Tableau after pivot (leaving row %d, entering col %d):\n', leaving_row, entering_col);
       disp(tableau);
    end
    error('Maximum iterations reached in simplex_method.');
end


function [x_opt, z_opt, tableau, basic_vars] = simplex_method_given_basis(tableau, basic_vars, n)
    % SIMPLEX_METHOD_GIVEN_BASIS Continues the simplex method from a given
    % tableau and basis (used in Phase 2).
    %
    % Inputs:
    %    tableau    - initial tableau for Phase 2 (size: (m+1) x (n+1))
    %    basic_vars - current basic variable indices (for the m constraint rows)
    %    n          - number of original variables
    %
    % Outputs:
    %    x_opt      - optimal solution vector (n x 1)
    %    z_opt      - optimal objective function value
    %    tableau    - final simplex tableau
    %    basic_vars - updated basic variable indices
    
    [m_plus, total_cols] = size(tableau);
    m = m_plus - 1;  % number of constraints
    tol = 1e-8;
    iter = 0;
    max_iter = 1000;
    
    while iter < max_iter
       iter = iter + 1;
       
       % --- Optimality test ---
       if all(tableau(end, 1:end-1) >= -tol)
           x_opt = zeros(n, 1);
           for i = 1:m
              if basic_vars(i) <= n
                 x_opt(basic_vars(i)) = tableau(i, end);
              end
           end
           z_opt = tableau(end, end);
           fprintf('Optimal tableau reached in Phase 2 after %d iterations.\n', iter);
           return;
       end
       
       % --- Choose entering variable (Bland's rule) ---
       entering_candidates = find(tableau(end, 1:end-1) < -tol);
       entering_col = min(entering_candidates);
       
       % --- Unboundedness check ---
       col = tableau(1:m, entering_col);
       if all(col <= tol)
           error('Linear program is unbounded in Phase 2.');
       end
       
       % --- Minimum ratio test (with Bland tie-break) ---
       ratios = inf(m, 1);
       for i = 1:m
           if tableau(i, entering_col) > tol
              ratios(i) = tableau(i, end) / tableau(i, entering_col);
           end
       end
       min_ratio = min(ratios);
       leaving_candidates = find(abs(ratios - min_ratio) < tol);
       leaving_row = min(leaving_candidates);
       
       % --- Pivot ---
       tableau = pivot(tableau, entering_col, leaving_row);
       basic_vars(leaving_row) = entering_col;
       
       fprintf('Tableau after pivot (leaving row %d, entering col %d):\n', leaving_row, entering_col);
       disp(tableau);
    end
    error('Maximum iterations reached in simplex_method_given_basis.');
end


function tableau = pivot(tableau, entering_col, leaving_row)
    % PIVOT Performs the pivot operation on the tableau.
    % It scales the leaving row and then clears the entering column in all
    % other rows.
    %
    % Inputs:
    %    tableau      - current simplex tableau
    %    entering_col - column index for the entering variable
    %    leaving_row  - row index for the leaving variable
    %
    % Output:
    %    tableau - updated tableau after the pivot operation
    
    [num_rows, ~] = size(tableau);
    pivot_element = tableau(leaving_row, entering_col);
    
    % Scale the pivot (leaving) row.
    tableau(leaving_row, :) = tableau(leaving_row, :) / pivot_element;
    
    % Zero out the rest of the column.
    for i = 1:num_rows
        if i ~= leaving_row
            tableau(i, :) = tableau(i, :) - tableau(i, entering_col) * tableau(leaving_row, :);
        end
    end
end
