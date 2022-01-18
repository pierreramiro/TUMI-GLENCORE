clear;
Point_Cloud=readmatrix("data.csv");
%% desplazamos los puntos 0.353 a la derecha
unit_vec=Point_Cloud(2,:)-Point_Cloud(1,:);
unit_vec=unit_vec/norm(unit_vec);
dist=0.353;
point_uno=Point_Cloud(1,:)+dist*unit_vec;
point_dos=Point_Cloud(2,:)+dist*unit_vec;
Point_Cloud(1:2,:)=[point_uno;point_dos];
%%
new_Point_Cloud=zeros(size(Point_Cloud));
translation_vector=-Point_Cloud(1,:);
for i=1:length(Point_Cloud)
    new_Point_Cloud(i,:)=Point_Cloud(i,:)+translation_vector;
end
writematrix(new_Point_Cloud(1:end-2,:),"new_data.csv");
%%
pcshow(new_Point_Cloud(1:200,:)),
