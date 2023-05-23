function [xx] = Mappingg(x)

xx = tanh(x);
[~,c] = size(xx);

for i=1:c
    if rand<xx(i)
        xx(i) = 1;
    else
        xx(i) = 0;
    end
end
end