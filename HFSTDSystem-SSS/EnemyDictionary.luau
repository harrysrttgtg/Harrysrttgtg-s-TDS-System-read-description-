
--[[
# Notes
- Please use the Dictionary table and not the EnemyDictionary table, this is done just for security reasons
to prevent scripts from modifing the table within a running game instance!

- Ensure that you follow the formatting listed below to ensure you don't encounter any bugs.

# FORMAT
- Here is a guide for how to format this dictonary properly;

Dictionary
	EnemyType
		Variants
			Speed — Number: The walkspeed of the Enemy.
			Health — Number: The Health that the Enemy spawns at.
			Shield — Number: An additional amount of HP a Enemy spawns with ontop of the Health.
			-- You may add more if you wish for your game!

]]

-----------------------------------------------------------------------------------------
const Dictionary = {
	Zombie = {
		Zombie = {
			Speed = 10,
			Health = 10,
			Shield = 0
		},
		FastZombie = {
			Speed = 15,
			Health = 5,
			Shield = 0
		}
	},
}
-----------------------------------------------------------------------------------------

local function deepCopy(original, seen: { [any]: any }?)
	if type(original) ~= "table" then
		return original
	end

	local tracker = seen or {}
	if tracker[original] then
		return tracker[original]
	end

	local copy = {}
	tracker[original] = copy

	for key, value in original :: any do
		local copiedKey = deepCopy(key, tracker)
		local copiedValue = deepCopy(value, tracker)
		copy[copiedKey] = copiedValue
	end

	local metatable = getmetatable(original :: any)
	if metatable then
		setmetatable(copy, deepCopy(metatable, tracker))
	end

	return copy
end
--------------------------------------

local EnemyDictionary = {}

function EnemyDictionary.GetCopy()
	return deepCopy(Dictionary)
end

return EnemyDictionary