const EnemySpawning = require(script.Parent.Parent.EnemySpawning)

local Easy = {}

function Easy.Wave1()
	for i=1, 5 do
		EnemySpawning.SpawnNewEnemy("Zombie", nil, {"Forest", "A"})
		task.wait(0.5)
	end
end
function Easy.Wave2()
	for i=1, 5 do
		EnemySpawning.SpawnNewEnemy("Zombie", "FastZombie", {"Forest", "A"})
		task.wait(0.5)
	end
end
function Easy.Wave3()
	for i=1, 5 do
		EnemySpawning.SpawnNewEnemy("Zombie", "FastZombie", {"Forest", "A"})
		task.wait(0.5)
	end
	task.wait(2)
	for i=1, 10 do
		EnemySpawning.SpawnNewEnemy("Zombie", nil, {"Forest", "A"})
		task.wait(0.5)
	end
end
function Easy.Wave4()
	for i=1, 5 do
		EnemySpawning.SpawnNewEnemy("Zombie", "FastZombie", {"Forest", "A"})
		task.wait(0.5)
	end
	task.wait(2)
	for i=1, 10 do
		EnemySpawning.SpawnNewEnemy("Zombie", nil, {"Forest", "A"})
		task.wait(0.5)
	end
end
function Easy.Wave5()

end

--------------------------------------------------------------

function Easy.Run()
	local x1 = Easy.Wave1()
	local x2 = Easy.Wave2()
	local x3 = Easy.Wave3()
	local x4 = Easy.Wave4()
	local x5 = Easy.Wave5()
end

return Easy