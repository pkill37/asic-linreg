clear all; close all; clc;

m = 6;
n = 2;

theta = [
    1.01;
    2.02
];

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

alpha = 0.01;

for i = 1:1000
    hypothesis = (X*theta);
    err = hypothesis - Y;
    tmp1 = (X' * err);
    scalar = (alpha/m);
    tmp2 = (tmp1 * scalar);
    theta = theta - tmp2
end
