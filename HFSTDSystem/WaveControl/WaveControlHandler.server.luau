const ReplicatedStorage = game:GetService("ReplicatedStorage")

const EnemySpawning = require(script.Parent.Parent.EnemySpawning)
EnemySpawning.Init()

---####---

const TimeDelayToChoseGamemode = 5 -- (Seconds)
const TimeDelayToGameStart = 5 -- (Time delay from gamemode chosen to game start)

----------------------------------------------------------------------------------------------------
-- Logic to chose gamemode MUST RETURN IT BACK!!!
const function ChoseGamemode()
	return "Easy" -- you may add your own logic here to change gamemode!
end

const function FindGamemode(Gamemode)
	local found = nil
	for i, v in pairs(script.Parent:GetDescendants()) do
		if v.Name == Gamemode and v:IsA("ModuleScript") then
			found = v
			break
		end
	end
	return found
end

const function ConfigureEvents()
	local RSFolder = Instance.new("Folder", ReplicatedStorage)
	RSFolder.Name = "HarrysrttgtgsTDS-RS"
	
	local NewWaveEvent = Instance.new("BindableEvent", RSFolder)
	NewWaveEvent.Name = "NewWaveBindable"
	
	local NewWaveRemote = Instance.new("RemoteEvent", RSFolder)
	NewWaveRemote.Name = "NewWaveRemote"
	
	
end

const function GameLaunchHandler()
	
	print("STARTING GAME:")
	ConfigureEvents()
	local Gamemode = ChoseGamemode()
end

GameLaunchHandler()