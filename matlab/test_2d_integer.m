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

s = 2048;
base = log(s)/log(2);
X = fix(X*s);
Y = fix(Y*s);
theta = fix(theta*s);
alpha = fix(alpha*s);

for i = 1:1000
    hypothesis = bitshift(X*theta, -base);
    err = fix(hypothesis - Y);
    tmp1 = bitshift(X' * err, -base);
    scalar = fix((alpha/m));
    tmp2 = bitshift(tmp1 * scalar, -base);
    theta = fix(theta - tmp2)
    %theta/s
end
