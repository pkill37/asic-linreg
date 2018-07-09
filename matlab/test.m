close all; clear all; clc;

tic
m = 30;
n = 3;

%X = [1,2,5; 1,3,6; 1,4,7];
%Y = [0;1;2];

X = [   1, 0, 0; 
        1, 1, 2;
        1, 2, 1;
        1, 6, 7;
        1, 3, 2; 
        1, 4, 5; 
        1, 3, 6; 
        1, 2, 2;
        1, 4, 4;
        1, 7, 3;
        1, 7, 5;
        1, 9, 6;
        1, 8, 9;
        1, 11, 5;
        1, 11, 12;
        1, 12, 9;
        1, 8, 5;
        1, 10, 7;
        1, 13, 15;
        1, 20, 14;
        1, 17, 17;
        1, 16, 7;
        1, 15, 3;
        1, 20, 6;
        1, 30, 17
        1, 2, 10
        1, 5, 10
        1, 5, 16
        1, 25, 12;
        1, 23, 18];

Y = [1; 
     3; 
     4;
     8;
     4;
     5; 
     6; 
     5;
     6;
     4;
     6;
     7;
     9;
     9;
     14;
     10;
     8;
     10;
     11;
     15;
     17;
     12;
     14;
     16;
     22;
     8;
     20;
     27;
     3;
     19];   


theta = [1;2;2];
alpha = 0.003;
scalar = alpha/m;

s = 10000;
theta = theta * s;
alpha = alpha * s;
scalar = alpha/m;
X = X*s;
Y = Y*s;

for i = 1:100000
    hypothesis = (X*theta)/s;
    err = hypothesis - Y;
    tmp1 = (X' * err)/s;
    tmp2 = (tmp1 * scalar)/s;
    theta = theta - tmp2
end
toc

scatter3(X(:,2), X(:,3), Y);
xlabel('X');
ylabel('Y');
zlabel('Z');
hold on

x = X(:,2);
y = X(:,3);
[x1, y1] = meshgrid(x,y);
z = (theta(1) + theta(2)*x1 + theta(3)*y1);
surf(x1,y1,z);
fprintf('\nDone');
