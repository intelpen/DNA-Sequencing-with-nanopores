global Gating;
for i=1:43
    Gating(i).Vg=i/2
end

for i=44:87
    Gating(i).Vg=21+(43-i-1)/2
end
%EstimateIrmsIntegrated(1)
