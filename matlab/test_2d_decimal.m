tic
m = 10;
n = 2;

theta = [1.01; 2.02];

X = [
    1, 2.34;
    1, 3.77;
    1, 4.54;
    1, 5.81;
    1, 6.12;
    1, 5.01;
    1, 3.09;
    1, 4.14;
    1, 1.48;
    1, 2.20
];

Y = [
    4.12;
    3.04;
    3.19;
    6.35;
    4.73;
    6.77;
    1.39;
    5.76;
    3.27;
    2.82
];

alpha = 0.11;

for i = 1:5
    hypothesis = (X*theta);
    err = hypothesis - Y;
    tmp1 = (X' * err);
    scalar = (alpha/m);
    tmp2 = (tmp1 * scalar);
    theta = theta - tmp2
end
theta

%scatter(X(:,2), Y);
%xlabel('X');
%ylabel('Y');
%hold on

%x = X(:,2);
%y = (theta(1) + theta(2)*x);
%plot(x,y);
