const Players = game:GetService("Players")

--------------------------------------------------------------------------

local Utilities = {}

-- Kicks all the players inside of the running server, effectively shutting down the server. Ignored Players should be a table of UserIds
function Utilities.KickAllPlayers(KickMessage, IgnoredPlayers)
	for i, plr in pairs(Players:GetPlayers()) do
		local ignore = false
		for x, ignored in IgnoredPlayers do
			if IgnoredPlayers[x] == plr.UserId then
				ignore = true
				break
			end
		end
		
		if not ignore then
			plr:Kick(KickMessage)
		end
	end
end

return Utilities
