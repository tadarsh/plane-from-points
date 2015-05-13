k = 5;
points = csvread('../data/hall.csv');
cluster_ids = kmeans(points(:, 1:3), k);
figure;
hold all;
colors = {'MidnightBlue'; 'red'; 'olive'; 'cyan'; 'yellow'};
clusters = [];

for i = 1:k
    curr_points = points((cluster_ids == i), :);
    plot3(curr_points(:, 1), curr_points(:, 2), curr_points(:, 3), '.');
end
waitforbuttonpress;
close all;
for i = 1:k
    curr_points = points((cluster_ids == i), :);
    %plot3(curr_points(:, 1), curr_points(:, 2), curr_points(:, 3), '.');
    curr_cluster.id = i;    
    curr_cluster.planes = get_all_planes(curr_points, [0.1; pi/6]);
    clusters = [clusters; curr_cluster];
end
close all;
for i = 1:k
    fprintf(1, 'Cluster %d\n', i);
    %figure;
    hold all;
    planes = clusters(i).planes;
    for j = 1:size(planes, 1)
        plot3(planes(j).points(:, 1), planes(j).points(:, 2), planes(j).points(:, 3), '.');
    end
    waitforbuttonpress;
end