%% Modul INI
%clear all
%close all
%pcode main.m
global RP PAR Modul Blues Yellows Balls Rules; 
if (isempty(Blues) || isempty(Yellows) || isempty(Balls))
    main
    INIPosition();
else
    main
end
if isempty(Modul)    
    Modul.Tend=30000; %����� ���������� �������������
    Modul.dT=0.05;    %��� �������������
    Modul.Delay=0.15;%0.05   %�������� ����������
    Modul.vSpeed=5;    %��������� �������� �������� �������
    Modul.l_wheel=100; %������ ������
    Modul.T=0;         %����� ���������� ��������� 
    Modul.N=0;         %����� ���� ���������  
    Modul.viz=0;       %��������������� �� �������������� ��������?
    Modul.MapError=0*[0,5,5,0.05]; %����������� �������� ��������� %0.08-0.11

    Modul.treckcolor=[0,1,0.4];
    %��������� ��� ���������� ������ �������������
    Modul.Save.Yellows=Yellows;
    Modul.Save.Blues=Blues;
    Modul.Save.Balls=Balls;
    Modul.YellowsKick=zeros(size(Yellows,1),2);
    Modul.BluesKick=zeros(size(Blues,1),2);
    Modul.Ball.Ang=0;      
    Modul.Ball.V=0;
end
MAP_INI();
MAP();