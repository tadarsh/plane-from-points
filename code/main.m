% Clustering the points and detecting planes
clusters = cluster_points('../data/hall_color.csv');

% Densifying all planes
get_reconstructed_points('../data/reconstructions/hall_dense', clusters);
