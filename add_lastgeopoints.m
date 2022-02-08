%% Definimos la proporción y la altura de los primeros puntos georeferenciados
clear
proporcion=2.547;
altura=1;%La misma de los puntos georeferenciados
PointCloud=readmatrix("georef_cloud.csv");
altura=(proporcion+1)*altura;
%% Hallamos los vectores unitarios necesarios para definir los puntos de georeferencia
temp1=PointCloud(end-220,:)-PointCloud(end-219,:);
temp1=temp1/norm(temp1);
temp2=PointCloud(end-89,:)-PointCloud(end-90,:);
temp2=temp2/norm(temp2);
outter_vec=-cross(temp1,temp2);
outter_vec=outter_vec/norm(outter_vec);
side_rigth_vec=[515.078335690855,-1310.25037092236,4.08281322017900]-[5.133729973152860e+02,-1.309057917884610e+03,4.003824605768490];
side_rigth_vec=side_rigth_vec/norm(side_rigth_vec);
% temp=PointCloud(end-288+1:end,:);
% temp=[PointCloud(end-288*20+1:end,:);temp+10*siderigth_vec];
% pcshow(temp)
height_vec=cross(side_rigth_vec,outter_vec);
height_vec=-height_vec/norm(height_vec);
%% Procedemos a ubicar los puntos de georeferencia
punto_inicial=[5.150783356908550e+02,-1.310250370922360e+03,4.082813220179000];
%elevamos el punto con la altura correspondiente
C_point=punto_inicial+height_vec*altura;
%Lo movemos a la derecha
C_point=C_point+0.24658*side_rigth_vec;
%Ahora lo sacamos un poco del anillo
C_point=C_point+0.17221*outter_vec;
%Con el punto C, podemos hallar el punto D
D_point=C_point-(0.24658*2+2.08241)*side_rigth_vec;
%% Creamos la matrix final
writematrix([PointCloud;C_point;D_point],"georef_cloud_ABCD.csv")
