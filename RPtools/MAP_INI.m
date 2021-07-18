%MAP_INI 
%������������� ��������� MAP � �������� figure(100).
%��� ������� ���������������� ��������� ������.

global PAR; 
if (isempty(PAR))
    error('<PAR>: struct PAR is not initialized! Run main.m...');
end

global Blues Yellows MAP_PAR
%clear MAP_PAR;  
MAP_PAR.MAP_H=figure(100);

clf
hold on;grid on;

MAP_PAR.viz_text=[];

axis equal
axis([-PAR.MAP_X/2-150,PAR.MAP_X/2+150,-PAR.MAP_Y/2-100,PAR.MAP_Y/2+100]);
plot(PAR.MAP_X/2*[-1,1,1,-1,-1],PAR.MAP_Y/2*[1,1,-1,-1,1],'W--');

if isfield(PAR,'LGate')
    [temp_X,temp_Y]=rotV([0,-90,-90,0],PAR.LGate.width*[0.5,0.5,-0.5,-0.5],PAR.LGate.ang);    
    plot(PAR.LGate.X+temp_X,...
        PAR.LGate.Y+temp_Y,'B','LineWidth',3)
end
if isfield(PAR,'RGate')
    [temp_X,temp_Y]=rotV([0,-90,-90,0],PAR.RGate.width*[0.5,0.5,-0.5,-0.5],PAR.RGate.ang);
    plot(PAR.RGate.X+temp_X,...
        PAR.RGate.Y+temp_Y,'B','LineWidth',3)
end
plot(500*sin(0:0.1:2*pi),500*cos(0:0.1:2*pi),'W-.');
set(gca,'Color',[0.1 0.9 0.1]);

MAP_PAR.viz_Balls=[];

for i=1:size(Blues,1)
    MAP_PAR.viz_Blues{i}=[];
end
for i=1:size(Yellows,1)
    MAP_PAR.viz_Yellows{i}=[];
end

clear temp_X temp_Y