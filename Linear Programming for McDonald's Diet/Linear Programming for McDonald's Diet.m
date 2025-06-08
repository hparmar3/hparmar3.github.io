% McDonald's Diet Linear Program

%Part B

c = [5.29, 2.99, 2.69, 5.43, 2.59];

A = [
    -590, -170, -140, -310, -150;
    -46, -10, -18, -30, -39;
    -25, -9, -2, -17, 0;
    34, 10, 8, 13, 0;
    85, 25, 0, 250, 0; 
    1050, 330, 310, 770, 40
];

b = [-2000; -275; -50; 78; 300; 2300];

x = linprog(c, A, b, [], [], zeros(5,1), []);

disp(x);

optimal_cost = c' * x;

% Part C
c(5) = 500;
x_expensive_coke = linprog(c, A, b, [], [], zeros(5,1), []);

disp(x_expensive_coke);

optimal_cost_expensive = c' * x_expensive_coke;

% Pard D
b_adjusted = b;
b_adjusted(4) = 135;
b_adjusted(5) = 100; 
b_adjusted(6) = 5000; 

x_adjusted = linprog(c, A, b_adjusted, [], [], zeros(5,1), [])

disp(x_adjusted);

optimal_cost_expensive = c' * x_adjusted;
