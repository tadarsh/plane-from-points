function cstruct = contour2poly(c)
idxlabel = 1;
l = 1;
cstruct = struct('level', {}, 'x', {}, 'y', {});
while idxlabel <= size(c,2)
    n = c(2,idxlabel);
    cstruct(l).x = c(1,idxlabel+(1:n));
    cstruct(l).y = c(2,idxlabel+(1:n));
    cstruct(l).level = c(1,idxlabel);
    l = l+1;
    idxlabel = idxlabel+n+1;
end

end 