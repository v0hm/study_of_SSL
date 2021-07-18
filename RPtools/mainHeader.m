%������� ���������� �������� "main" �������.
%������������ ��� ���������������� ��������� RP .
%
% �������� ��������� RP
%        zMain_End: true          %���� ���������� ���������� main
%          OnModul: 0             %������������� �������������
%              PAR: [1x1 struct]  %����� �������� ���������� ����
%               dT: 0.5           %��� �������������
%         T_timerH: 24084895062   %����� �������.
%                T: 12.5          %���� �� ������� �������
%     YellowsSpeed: [12x1 double] %�������� �����
%       BluesSpeed: [12x1 double] %�������� �����
%       BallsSpeed: 0             %�������� ����
%         Ballsang: 0             %���� ����������� ����
%            Blues: [16x4 double] %�������� ������ �����
%          Yellows: [16x4 double] %�������� ������ �����
%            Balls: [0 0 0]       %�������� ������ �����
%            Rules: [16x13 double]  %��������� ������ ����������
%             Ball: [1x1 struct]  %��������� ����
%             Blue: [1x16 struct] %��������� �����
%           Yellow: [1x16 struct] %��������� �����
%            Pause: 0             %�����
%
% �������� ��������� ������� RP.Blue(N) ��� RP.Yellow(N)
% ���� ����� �� ��� ������, �� ��� ���� empty
%           I: 1                  %������ ������, ������� ����� ������
%           x: 103.6005           %X ���������� ������
%           y: -905.6405          %Y ���������� ������ 
%           z: [103.6005 -905.6405]           %[X,Y] ����������
%         ang: 0.1835             %���� ����������� ������ 
%           v: 97.3253            %�������� �������� ������
%        Nrul: 0                  %����� ���������� ����������
%         rul: [1x1 struct]       %��������� ����������
%     KickAng: 0                  %����������� ����� ������
%
% �������� ���������� RP.Blue(10).rul
%      sound: 0                   %������ ���� [0..1]
%     sensor: 0                   %������������� ������ [0..4]
%       left: 100                 %��������� ������ ������ [-100..100]
%      right: 99.2465             %��������� ������� ������ [-100..100]
%       kick: -1                  %���� �������� [-1,0,1]

function RPre=mainHeader()
%% RP
global RP;
if isempty(RP)
    fprintf('<RP>: ---RP initial---\n');
    RP.inpair=false;    
end
if isfield(RP,'zMain_End') && (RP.zMain_End==false) && (RP.inpair==false)
    %fprintf('<RP>: main if FAIL!\n');
end
RP.zMain_End=false;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%experimential part----------------------------------------
global outBuffer;
if isempty(outBuffer)
    outBuffer = zeros(1, 16);
end
%----------------------------------------------------------
%% Data %%
emptyrul=Crul(0,0,0,0,0);
%�� SSL
% --- Balls ----
global Balls;
if isempty(Balls)   
    Balls=zeros(1, 6);  
end
% --- FieldInfo ---
global FieldInfo;
if isempty(FieldInfo)
    FieldInfo=zeros(1, 2);
end
% --- Referee ---
global RefState
if isempty(RefState)
	RefState = 0
end
global RefCommandForTeam
if isempty(RefCommandForTeam)
	RefCommandForTeam = 0
end
global RefPartOfFieldLeft
if isempty(RefPartOfFieldLeft)
	RefPartOfFieldLeft = 0
end
% --- Blues ----
global Blues;
if isempty(Blues)
    Blues=zeros(16, 5);
end
% --- Yellows ----
global Yellows;
if isempty(Yellows)
   Yellows=zeros(16, 5);
end
% --- Rules ��� BT ---
global Rules;
if isempty(Rules)
    Rules=zeros(16, 13);
end

global activeAlgorithm
if isempty(activeAlgorithm)
    activeAlgorithm = 0;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ������ �������� ������ %%
if ~isfield(RP,'pair')
    RP.pair=struct();
    if ~isfield(RP.pair,'Yellows')
        RP.pair.Yellows=-ones(size(Yellows,1),1);
    end
    if ~isfield(RP.pair,'Blues')
        RP.pair.Blues=-ones(size(Blues,1),1);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SYS %%
PAR=get_PAR(); %set def parametrs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- time ---
global Modul;
if isempty(Modul)
    RP.OnModul=false;
else
    RP.OnModul=true;
end
%RP.PAR=PAR;
% RP.T
% if isfield(RP,'T')
%     if isempty(Modul)
%         RP.dT=toc(RP.T_timerH);
%     else
%         RP.dT=Modul.T-RP.T;%Modul.dT;
%     end
%     RP.T_timerH=tic();
%     RP.T=RP.T+RP.dT;
% else
%     RP.dT=0;
%     RP.T_timerH=tic();
%     RP.T=0;
% end
if isfield(RP,'T')
    oldT=RP.T;
    if isempty(Modul)
        RP.T=toc(RP.T_timerH);
    else
        RP.T=Modul.T;
    end
    RP.dT=RP.T-oldT;
else
    RP.dT=0.01;
    RP.T_timerH=tic();
    RP.T=0;
end

%--- speed ---
% RP.YellowsSpeed
if ~isfield(RP,'YellowsSpeed')
    RP.YellowsSpeed=zeros(size(Yellows,1),1);
    RP.YellowsAngSpeed=zeros(size(Yellows,1),1);
    RP.BluesSpeed=zeros(size(Blues,1),1);
    RP.BluesAngSpeed=zeros(size(Blues,1),1);
    RP.BallsSpeed=zeros(size(Balls,1),1);
    RP.Ballsang=0;
end

if isfield(RP,'Yellows') && norm(size(Yellows)-size(RP.Yellows))==0    
    if (RP.dT>0)
        oldYellowsSpeed=RP.YellowsSpeed;
        oldYellowsAngSpeed=RP.YellowsAngSpeed;
        RP.YellowsSpeed=sqrt((Yellows(:,2)-RP.Yellows(:,2)).^2+(Yellows(:,3)-RP.Yellows(:,3)).^2)/RP.dT;    
        RP.YellowsAngSpeed=azi(Yellows(:,4)-RP.Yellows(:,4))/RP.dT;

        RP.YellowsSpeed(abs(azi(angV(Yellows(:,2)-RP.Yellows(:,2),Yellows(:,3)-RP.Yellows(:,3))-RP.Yellows(:,4)))>pi/2)=...
            -RP.YellowsSpeed(abs(azi(angV(Yellows(:,2)-RP.Yellows(:,2),Yellows(:,3)-RP.Yellows(:,3))-RP.Yellows(:,4)))>pi/2);
        
        NotActiv=or(Yellows(:,1)==0,RP.Yellows(:,1)==0);
        RP.YellowsAngSpeed(NotActiv)=oldYellowsAngSpeed(NotActiv);        
        RP.YellowsSpeed(NotActiv)=oldYellowsSpeed(NotActiv);        
    end
end
% RP.BluesSpeed
if isfield(RP,'Blues') && norm(size(Blues)-size(RP.Blues))==0
    if (RP.dT>0)
        oldBluesSpeed=RP.BluesSpeed;
        oldBluesAngSpeed=RP.BluesAngSpeed;
        RP.BluesSpeed=sqrt((Blues(:,2)-RP.Blues(:,2)).^2+(Blues(:,3)-RP.Blues(:,3)).^2)/RP.dT;    
        RP.BluesAngSpeed=azi(Blues(:,4)-RP.Blues(:,4))/RP.dT;

        RP.BluesSpeed(abs(azi(angV(Blues(:,2)-RP.Blues(:,2),Blues(:,3)-RP.Blues(:,3))-RP.Blues(:,4)))>pi/2)=...
            -RP.BluesSpeed(abs(azi(angV(Blues(:,2)-RP.Blues(:,2),Blues(:,3)-RP.Blues(:,3))-RP.Blues(:,4)))>pi/2);
        
        NotActiv=or(Blues(:,1)==0,RP.Blues(:,1)==0);
        RP.BluesAngSpeed(NotActiv)=oldBluesAngSpeed(NotActiv);        
        RP.BluesSpeed(NotActiv)=oldBluesSpeed(NotActiv);
    end
end
% RP.BallsSpeed

% if isfield(RP,'Balls') && norm(size(Balls)-size(RP.Balls))==0
%     activ=and(Balls(:,1)~=0,RP.Balls(:,1)~=0);
%     RP.BallsSpeed(activ)=sqrt((Balls(2)-RP.Balls(2)).^2+(Balls(3)-RP.Balls(3)).^2)/RP.dT;    
%     RP.Ballsang(activ)=angV(Balls(2:3)-RP.Balls(2:3));
% end

HeaderFilter();

%--- Save ---
RP.Blues=Blues;
RP.Yellows=Yellows;
RP.Balls=Balls;
RP.Rules=Rules;
%--- RP interface ---
id = find(Balls(:, 1), 1);
if (isempty(id))
   id = 1; 
end
RP.Ball.I=Balls(id, 1);
RP.Ball.x=Balls(id, 2);
RP.Ball.y=Balls(id, 3);
RP.Ball.z=Balls(id, 2:3);
%RP.Ball.ang=RP.Ballsang;
%RP.Ball.v=RP.BallsSpeed;
RP.Ball.id=100;
%% ���������� �������
if ~isfield(RP,'Extrap')
    RP.Extrap.ON=1; %�������� �� �������������� ������������� �������
                    %��� ���� ���� ����� �� ������, 
                    %�� ��� ������� ����� RP.Extrap.Time(1 �������) �����
                    %������ �������� ������ ������������� 3
	RP.Extrap.Time=1;
    for i=1:size(Blues,1)
        RP.Extrap.B{i}.T=inf;
    end
    for i=1:size(Yellows,1)
        RP.Extrap.Y{i}.T=inf;
    end
end

for i=1:size(Blues,1)
        RP.Blue(i).I=Blues(i,1);
        RP.Blue(i).z=Blues(i,2:3);        
        RP.Blue(i).x=Blues(i,2);       
        RP.Blue(i).y=Blues(i,3);
        RP.Blue(i).ang=Blues(i,4);
        RP.Blue(i).isBallInside=Blues(i, 5);
        RP.Blue(i).v=RP.BluesSpeed(i);
        RP.Blue(i).u=RP.BluesAngSpeed(i);                    
        RP.Blue(i).id=i;
%       RP.Blue(i).Nrul=7;
        RP.Blue(i).Nrul=RP.pair.Blues(i);
        RP.Blue(i).rul=emptyrul;
        RP.Blue(i).KickAng=0;

        if (RP.Blue(i).I)
            RP.Extrap.B{i}.T=0;
            RP.Extrap.B{i}.Last=RP.Blue(i);
        else
            if (RP.Extrap.B{i}.T<RP.Extrap.Time)
                RP.Extrap.B{i}.T=RP.Extrap.B{i}.T+RP.dT;
                agent=extrapR(RP.Extrap.B{i}.Last,RP.Extrap.B{i}.T);
                RP.Blue(i).z=agent.z;
                RP.Blue(i).ang=agent.ang;            
                RP.Blue(i).x=agent.x;       
                RP.Blue(i).y=agent.y;
                if (RP.Extrap.ON) 
                    RP.Blue(i).I=3;
                end
            end
        end
end
for i=1:size(Yellows,1)
        RP.Yellow(i).I=Yellows(i,1);
        RP.Yellow(i).z=Yellows(i,2:3);
        RP.Yellow(i).x=Yellows(i,2);
        RP.Yellow(i).y=Yellows(i,3);
        RP.Yellow(i).ang=Yellows(i,4);   
        RP.Yellow(i).isBallInside=Yellows(i,5);
        RP.Yellow(i).v=RP.YellowsSpeed(i);
        RP.Yellow(i).u=RP.YellowsAngSpeed(i);        
        RP.Yellow(i).Nrul=RP.pair.Yellows(i);
        RP.Yellow(i).rul=emptyrul;
        RP.Yellow(i).KickAng=0;
        RP.Yellow(i).id=size(Blues,1)+i;

        if (RP.Yellow(i).I)
            RP.Extrap.Y{i}.T=0;
            RP.Extrap.Y{i}.Last=RP.Yellow(i);
        else
            if (RP.Extrap.Y{i}.T<RP.Extrap.Time)
                RP.Extrap.Y{i}.T=RP.Extrap.Y{i}.T+RP.dT;
                agent=extrapR(RP.Extrap.Y{i}.Last,RP.Extrap.Y{i}.T);
                RP.Yellow(i).z=agent.z;
                RP.Yellow(i).ang=agent.ang;            
                RP.Yellow(i).x=agent.x;       
                RP.Yellow(i).y=agent.y;
                if (RP.Extrap.ON) 
                    RP.Yellow(i).I=3;
                end
            end
        end
end
RP.YELLOWIDMIN=size(Blues,1)+1;
% --- RP.Pause ---
if ~isfield(RP,'Pause')    
    RP.Pause=0;
end
Pair();
%% re
RPre=RP;
end