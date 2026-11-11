
const ReplicatedStorage = game:GetService("ReplicatedStorage")
const RunService = game:GetService("RunService")
const EnemiesStorage = ReplicatedStorage:WaitForChild("EnemiesStorage") -- Replace with storage for enemies


-- Change These to Match:
const SpawnFolder = workspace.SpawnedEnemies
const MapsFolder = workspace.Maps

const SpawningUpwardsOffset = 1.5 -- Offset that the enemies spawn relative to the spawnpoint's cframe.

----------------------------------------------------------------------

local function GetHorizontalDistance(a, b)
	local Difference = a - b
	return Vector2.new(Difference.X, Difference.Z).Magnitude
end

----------------------------------------------------------------------

local EnemySpawning = {}

-- Moves the Enemy along the pathway that was designed.
function EnemySpawning.MoveEnemyAlongPathway(NewEnemy, Map)
	local Humanoid = NewEnemy:FindFirstChildOfClass("Humanoid")
	
	if not Map or not Map:IsA("Folder") then
		warn("Map does not exist or it is not a folder!")
		warn(Map)
	end
	
	if Humanoid then
		local RootPart = NewEnemy:FindFirstChild("HumanoidRootPart")
		-- Is a rig: Using MoveTo()
		
		local Waypoints = Map:FindFirstChild("Waypoints")
		
		for i, v in ipairs(Waypoints:GetChildren()) do
			if v:IsA("BasePart") then
				Humanoid:MoveTo(v.Position)
				
				local StartTime = os.clock()
				
			else
				-- debugging
				warn("Instance in the Waypoints folder is not a basepart, please investigate this...")
				warn("Map: " .. tostring(Map))
				warn("Item/Instance: " .. tostring(v))
			end
		end
		NewEnemy:Destroy()
	else
		-- debugging
		-- Is not a rig: This system does not support of non-rigged.
		warn("The 'NewEnemy' does not contain a humanoid within itself.")
		warn("Please ensure that all Enemies within EnemiesStorage contains a humanoid within themselves...")
		return nil
	end
end

-- Places the Enemy into the workspace. Returns NewEnemy or nil.
function EnemySpawning.PlaceInWorkspace(NewEnemy, Location)
	local MapName = Location[1]
	local SpawnpointName = Location[2]
	
	if MapName and SpawnpointName then
		
		local Map = MapsFolder:FindFirstChild(MapName)
		local Spawnpointsfolder = Map and Map:FindFirstChild("Spawnpoints")
		local Spawnpoint = Spawnpointsfolder and Spawnpointsfolder:FindFirstChild(SpawnpointName)
		
		-- Debugging
		if not Spawnpoint or not Spawnpoint:IsA("BasePart") then
			warn("One of the following not found:")
			warn("Map: " .. tostring(Map))
			warn("Spawnpoints (folder): " .. tostring(Spawnpointsfolder))
			warn("Spawnpoint: " .. tostring(Spawnpoint))
			return nil
		end
		
		-----------
		
		NewEnemy:PivotTo(Spawnpoint.CFrame * CFrame.new(0, SpawningUpwardsOffset, 0))
		
		-- Putting the NewEnemy into a workspace location
		local MapSpawnFolder = SpawnFolder:FindFirstChild(MapName)
		
		if not MapSpawnFolder then
			MapSpawnFolder = Instance.new("Folder")
			MapSpawnFolder.Name = MapName
			MapSpawnFolder.Parent = SpawnFolder
		end
		
		NewEnemy.Parent = MapSpawnFolder
		
		return Map
	else
		-- debugging
		warn("Map AND/OR Spawnpoint has not been found;")
		warn("Map: " .. tostring(MapName))
		warn("Spawnpoint: " .. tostring(SpawnpointName))
	end
end
-- Begins the Enemy Spawning sequence.
function EnemySpawning.SpawnNewEnemy(EnemyType, Variant, Location)
	--[[
	EnemyType: String — A name given to each enemy type.
	
	EnemyVariant: String — Defines different variants of enemies under the same group
	e.g. Fast Zombie, which is a part of 'Zombie'.
	
	Location: {Map, Spawnpoint} — Where exactly to spawn the enemy. The 'Map' is tied to the map
	which the enemy is going to spawn at, useful if you may need more than one pathway which
	enemies may spawn on. If you have more than one spot where an enemy may spawn on one of these maps
	you can define it with Spawnpoint.
	]]
	
	local EnemyTypeFolder = EnemiesStorage:FindFirstChild(EnemyType)
	
	if EnemyType and EnemyTypeFolder and Location then
		
		local NewEnemy = nil
		
		if Variant then
			-- Logic for if theres a variant.
			local EnemyVarient = EnemyTypeFolder:FindFirstChild(Variant)
			
			if not EnemyVarient then
				-- debugging
				warn("Could not find Enemy Variant in folder: " .. tostring(Variant))
				return nil
			end
			
			NewEnemy = EnemyVarient:Clone()
		else
			-- Varient is nil, just finds the default enemy.
			local EnemyDefault = EnemyTypeFolder:FindFirstChild(EnemyType)
			
			NewEnemy = EnemyDefault:Clone()
		end
		
		if NewEnemy then
			local Map = EnemySpawning.PlaceInWorkspace(NewEnemy, Location) -- Also runs the function
			-- returns the map back
			
			coroutine.wrap(EnemySpawning.MoveEnemyAlongPathway)(NewEnemy, Map)
		end
		
	else
		-- debugging.
		warn("No EnemyType found: " .. tostring(EnemyType))
		warn("AND/OR")
		warn("Location does not exist: " .. tostring(Location))
		return nil
	end
end

return EnemySpawning
