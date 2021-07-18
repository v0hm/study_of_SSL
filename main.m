%% MAIN START HEADER

global  Blues Yellows Balls Rules FieldInfo RefState RefCommandForTeam RefPartOfFieldLeft RP PAR Modul activeAlgorithm obstacles gameStatus i naprav f

if isempty(RP)
    addpath tools RPtools MODUL algorithms
end
%
mainHeader();
%MAP();

if (RP.Pause) 
    return;
end

zMain_End=RP.zMain_End;

umax = 10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONTROL BLOCK



fprintf('%f ___ %f \n', RP.Blue(5).x, RP.Blue(5).y);
RP.Blue(5).ang = RP.Blue(5).ang * (-180/pi);  
fprintf('%f\n', (RP.Blue(5).ang));
u = GoToPoint([RP.Blue(5).x, RP.Blue(5).y], [0, 0]) - RP.Blue(5).ang;
if abs(u) > 25
    u = sign(u) * 25;
end 

fprintf('%f\n', u);

RP.Blue(6).rul = Crul(10, 0, 0, u, 0);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% MAIN END

%Rules

zMain_End = mainEnd();