function get_reconstructed_points(filename, clusters)
    points = [];
    normals = [];
    colors = [];

    for i = 1:size(clusters, 1)    
        planes = clusters(i).planes;
        for j = 1:size(planes, 1)
            [a, b, c] = fill_new_points(planes(j));
            points = [points;a];
            colors = [colors;b];
            normals = [normals;c];
        end
    end
    X = [points(:,1:3) normals(:,1:3) colors];
    csvwrite(strcat(filename, '.csv'), X);
    
    %Converting csv to ply file
    command = ['python csv2ply.py ', filename, '.csv ', filename, '.ply'];
    system(command);
end

