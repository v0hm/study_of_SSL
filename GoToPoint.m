function Ready = GoToPoint(bot_num, targetpos, speed)
	u = atan2d(targetpos(2) - RP.Blue(bot_num).y, targetpos(1) - RP.Blue(bot_num).x) * -1;
	RP.Blue(bot_num + 1).rul = Crul(speed, 0, 0, u, 0);
	if (sqrt((targetpos(2) - RP.Blue(bot_num).y)^2 + ((targetpos(1) - RP.Blue(bot_num).x)^2)) < 10)
		Ready = true;
	end
end