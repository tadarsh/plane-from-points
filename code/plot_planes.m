close all;
points = csvread('../data/hall.csv');
plot3(points(:, 1), points(:, 2), points(:, 3), 'b.');

load('planes.mat');

hold on;
points = plane_inliers{1};
plot3(points(:, 1), points(:, 2), points(:, 3), 'g.');

points = plane_inliers{2};
plot3(points(:, 1), points(:, 2), points(:, 3), 'k.');

points = plane_inliers{3};
plot3(points(:, 1), points(:, 2), points(:, 3), 'y.');

points = plane_inliers{4};
plot3(points(:, 1), points(:, 2), points(:, 3), 'm.');

points = plane_inliers{5};
plot3(points(:, 1), points(:, 2), points(:, 3), 'c.');









