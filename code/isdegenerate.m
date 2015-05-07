%----------------------------------------------------------------------
% Function to determine if a set of 3 points are collinear
% to a degeneracy in the calculation of a homography as needed by RANSAC.
     
function r = isdegenerate(X)
    r = iscolinear(X(1:3,1),X(1:3,2),X(1:3,3));
end
    
