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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONTROL BLOCK


if status == "restart"
    if side = "left"
        if GoToPoint(bots_nums(1), bots_start_pos_left(1), 10)
            status = "ready";
            fprintf("%f\n", "ready");
        end
        %GoToPoint(bots_nums(2), bots_start_pos_left(2));
    elseif side = "right"
        GoToPoint(bots_nums(1), bots_start_pos_right(1), 10);
        %GoToPoint(bots_nums(2), bots_start_pos_right(2));
    end
elseif status == "game"

elseif status == "penalty"

elseif status == "ready"
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% MAIN END

%Rules

zMain_End = mainEnd();