function AngleToPoint = GoToPoint(pos, targetpos)
	AngleToPoint = atan2d(targetpos(2) - pos(2), targetpos(1) - pos(1)) * -1;
end