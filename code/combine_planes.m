new_planes = containers.Map();
plane_id = 1;
for i=1:k
    planes = clusters(i).planes;
    for j = 1:size(planes,1)
        is_new_plane = true;
        keys = new_planes.keys();
        for z = 1:size(keys, 2)
            if is_same_plane(planes(j).plane, new_planes(keys{z}).plane)
                is_new_plane = false;
                break;
            end            
        end
        if is_new_plane
            new_planes(int2str(plane_id)) = planes(j);
            plane_id = plane_id + 1;
        else
            merged_plane.plane = new_planes(keys{z}).plane;
            merged_plane.points = [new_planes(keys{z}).points;planes(j).points];
            new_planes(keys{z}) = merged_plane;
        end
    end
end
close all;
figure;
hold all;
plane_keys = new_planes.keys();
for i = 1:size(plane_keys, 2)
curr_plane = new_planes(plane_keys{i}).points;
plot3(curr_plane(:, 1), curr_plane(:, 2), curr_plane(:, 3), '.');
waitforbuttonpress;
end