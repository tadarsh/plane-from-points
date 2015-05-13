function [color] = get_average_plane_color(plane)
%GET_AVERAGE_PLANE_COLOR Summary of this function goes here
%   Detailed explanation goes here
    points = plane.points;
    colors = points(:, 7:10);
    color = floor(mean(colors));
end

