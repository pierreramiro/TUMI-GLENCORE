clearvars -except PointCloud;
close all
points_per_ring=1440/5;
PointCloud=readmatrix("new_data.csv");
%Dado que al final hay muchos anilos repetidos, eliminamos una cantidad de
%1069 anillos
init=5266946+1;
fin=5266946+points_per_ring;
PointCloud=PointCloud(1:fin+1*points_per_ring,:);
%     %pcshow(PointCloud(end-1070*points_per_ring+1:end,:))
%     %init=5266946+1;
%     %fin=5266946+points_per_ring;
%     %pcshow(PointCloud(init:fin+1*points_per_ring,:))
%% Procedemos a analizar lls ultimos dos anillos y los extendemos
%pcshow(PointCloud(end-3*points_per_ring:end,:))
penult_ring=PointCloud(end-2*points_per_ring+1:end-1*points_per_ring,:);
final_ring=PointCloud(end-1*points_per_ring+1:end,:);
%Ahora buscamos el índice del punto del centro
%% penult_point
%figure
%scatter3(penult_ring(:,1),penult_ring(:,2),penult_ring(:,3))
% for i=1:length(penult_ring)
%     if isequal(cursor_info.Position,penult_ring(i,:))
%         break
%     end
% end
index_penult_point=2;
penult_point=penult_ring(index_penult_point,:);
%% final_point
% figure
% scatter3(final_ring(:,1),final_ring(:,2),final_ring(:,3))
% for i=1:length(final_ring)
%      if isequal(cursor_info.Position,final_ring(i,:))
%          break
%      end
%  end
index_final_point=1;
final_point=final_ring(index_final_point,:);
%% Hallamos el vector desplazamiento
trasl_vector=final_point-penult_point;
%Ahora debemos definir la distancia entre nubes para saber la cantidad de 
%nubes a agregar y tambien definir la distancia a extender
delta_dist=0.033;
total_dist=20;
%procesamos la data y extendemos
trasl_vector=trasl_vector*delta_dist/norm(trasl_vector);
n_clouds_to_extend=round(20/delta_dist);
for i=1:n_clouds_to_extend
    PointCloud=[PointCloud;final_ring+trasl_vector*i];
end
writematrix(PointCloud,"cloud_extended.csv")
