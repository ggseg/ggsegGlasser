wd = '/net/tsd-evs.tsd.usit.no/p23/home/p23-didacvp/GGSEG/hcpmmp1_0'
cd(wd)


[vertices label ctab] = read_annotation('lh.HCP-MMP1.annot');
ctab2 = ctab
 fid = fopen([wd filesep 'lh.labelname.txt'],'wt');
 M = ctab.struct_names
 if fid>0
     for k=1:size(M,1)
         fprintf(fid,'%s\n',M{k});
     end
     fclose(fid);
 end

i = randperm(length(ctab.table)-1);
i = [1, i+1]
ctab2.table = ctab.table(i,:);


ctab2.table(2:end,1:3) =  randi(256,[180 3])-1;
ctab2.table(2:end,1:3)

ctab2.table(:,5) = ctab2.table(:,4)*256^3 + ctab2.table(:,3)*256^2 +ctab2.table(:,2)*256 +ctab2.table(:,1)

q = [ctab.table(:,5),ctab2.table(:,5)];

l = zeros(1,length(vertices));
for ii = 1:(length(i))
   l(find(label == q(ii,1))) = q(ii,2);
end


%write_annotation(filename, vertices, label, ct)
write_annotation([wd filesep 'lh.test2.annot'], vertices, l, ctab2)
%(A * 2563) + (B * 2562) + (G * 256) + (R)


