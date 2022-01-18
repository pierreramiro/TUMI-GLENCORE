clear
PointCloud=readmatrix("Nueva_nube_georeferenciada.csv");
flags=readmatrix("flags_P5.csv");
flags=[flags;flip(readmatrix("flags_P6.csv"))];
flags=flags(1:5267522-2);
n_rings_to_extend=(length(PointCloud)-2-5267520)/288;
flags_last_ring=flags(end-288+1:end);
for i=1:n_rings_to_extend
    flags=[flags;flags_last_ring];
end
temp=[PointCloud(1,:),0;PointCloud(2,:),0;PointCloud(3:end,:),flags];
writematrix(temp,"Nube_georeferenciada_with_flags.csv")
fprintf("El numero de planos es: %f",(length(temp)-2)/288);
%%
% temp=PointCloud(3:end,:);
% camino=zeros(length(temp),3);
% for i=1:length(temp)
%     if flags(i)
%         camino(i,:)=temp(i,:);
%     end
% end
% writematrix(camino,"camino.csv")