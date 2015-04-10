%----------------------------------------------------------------------
% Function to evaluate the symmetric transfer error of a homography with
% respect to a set of matched points as needed by RANSAC.

function [inliers, p] = plane_dist_3d(p, x, t);
    
    d2 = (p' * x)/sqrt(p(1:3)' * p(1:3));
    inliers = find(abs(d2) < t);    

    %inliers = inliers'
end
    
 
