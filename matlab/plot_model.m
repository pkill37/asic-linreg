clear all; close all; clc;

X = [
    1, 2.34;
    1, 3.77;
    1, 4.54;
    1, 5.81;
    1, 6.12;
    1, 5.01;
];

Y = [
    4.12;
    3.04;
    3.19;
    6.35;
    4.73;
    6.77;
];

theta = [2217; 1586]/2048;

scatter(X(:,2), Y);
xlabel('X');
ylabel('Y');
hold on

x = X(:,2);
y = (theta(1) + theta(2)*x);
plot(x,y);
