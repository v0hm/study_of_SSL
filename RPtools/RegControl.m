function rul = RegControl(agent,rul)
if (nargin<2)
    rul=agent.rul;
end
%������ �� �����?
if (agent.I==0)
    %����� � �����.
    rul=Crul(0,0,0,1,0);
end
%�������� �� ��������.
rul.left(abs(rul.left)>100)=sign(rul.left)*100;
rul.right(abs(rul.right)>100)=sign(rul.right)*100;
global Yellows Blues
%����������� ����� ������� �����������
rul=ReactAvoidance(agent,rul,[Yellows;Blues]);
%������������ �� ������
rul=BoardControl(agent,rul);
%����������� ��������� ����������
rul=MoveControl(agent,rul);
end

