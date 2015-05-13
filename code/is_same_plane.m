function is_same = is_same_plane(plane1, plane2)
    % Each planes is [a, b, c, d]
    % first check if parallel
    is_same = true;
    cos_angle = dot(plane1(1:3), plane2(1:3))/(norm(plane1(1:3))*norm(plane2(1:3)));
    if abs(cos_angle) < cos(pi/10)
        is_same = false;
        return;
    end
    dist = sum(abs(plane1-plane2));
    if dist > 0.001
        is_same = false;
    end
end