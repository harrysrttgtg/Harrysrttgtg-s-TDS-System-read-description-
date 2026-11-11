local x = require(script.Parent.EnemySpawning)
x.Init()

for i=1, 100 do
	for i=1, 5 do
		x.SpawnNewEnemy("Zombie", "FastZombie", {"Forest", "A"})
		task.wait(0.5)
	end
	
	task.wait(5)
end