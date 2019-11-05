

[lo , Loci] = ismembertol(L1_list(:,2),L2_list(:,2),1e-6);
L1_eq_stable = L1_list(lo,:);
L2_eq_unstable = L2_list(Loci(lo),:);

[lo , Loci] = ismembertol(L1_list(:,2),L2_list(:,2),1e-6);
L1_eq_stable = L1_list(lo,:);
L2_eq_unstable = L2_list(Loci(lo),:);

