points_2d = curr_plane.points_2d(:, 1:2);
min_x = min(points_2d(:, 1));
min_y = min(points_2d(:, 2));
max_x = max(points_2d(:, 1));
max_y = max(points_2d(:, 2));
N = size(points_2d, 1);
centered_points_2d = points_2d - [min_x*ones(N, 1), min_y*ones(N, 1)];
centered_points_2d = centered_points_2d ./ [(max_x - min_x)*ones(N, 1), ...
                                    (max_y - min_y)*ones(N, 1)];
G = 1000;
image = zeros(G, G);
centered_points_2d = G * centered_points_2d;
for i = 1:size(centered_points_2d, 1)
    x = floor(centered_points_2d(i, 1));
    y = floor(centered_points_2d(i, 2));
    if y > 0
        image(x+1, y) = 1;
    end
    if x > 0
        image(x, y+1) = 1;
        if y > 0
            image(x, y) = 1;
        end
    end
    image(x+1, y+1) = 1;    
    
    if x < G+1
        if y < G+1
            image(x+2, y+2) = 1;        
        end
        image(x+2, y+1) = 1;    
    end
    if y < G+1    
        image(x+1, y+2) = 1;    
    end
end