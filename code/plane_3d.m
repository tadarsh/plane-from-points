function [p] = plane_3d(X)
% X = [x1 x2 x3] where each x1 is 3D point
% Returns a plane p = [a;b;c;d] such that ax + by + cz + d = 0
    x1 = X(:, 1);
    x2 = X(:, 2);
    x3 = X(:, 3);

    normal = cross(x2 - x1, x3 - x1);
    d = -x1' * normal;
    p = [normal; d];
end

