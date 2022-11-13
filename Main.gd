extends Node

var EnemyMob = preload("res://EnemyMob.tscn")
var EnemyVeteran = preload("res://EnemyVeteran.tscn")
var MobBullet = preload("res://MobBullet.tscn")
var VeteranBullet = preload("res://VeteranBullet.tscn")
var BigExplosion = preload("res://BigExplosion.tscn")
var SmallExplosion = preload("res://SmallExplosion.tscn")

var restart = false
var limit = 10
var bx_count = 0
var sx_count = 0
var big_explosion = []
var small_explosion = []
var bullet_dir = [
	Vector3(-.2, 0, 1).normalized(),
	Vector3(0, 0, 1),
	Vector3(.2, 0, 1).normalized(),
]

func spawn_big_explosion(pos):
	big_explosion[bx_count].translation = pos
	big_explosion[bx_count].emitting = true
	$AudioManager.play_big_explosion()
	
	bx_count += 1
	if bx_count == limit:
		bx_count = 0

func spawn_small_explosion(pos):
	small_explosion[sx_count].translation = pos
	small_explosion[sx_count].emitting = true
	$AudioManager.play_small_explosion()
	
	sx_count += 1
	if sx_count == limit:
		sx_count = 0

func enemy_destroyed(pos):
	spawn_big_explosion(pos)
	$UI.add_score()

func mob_shoot_bullet(pos):
	for i in 3:
		var mob_bullet = MobBullet.instance()
		mob_bullet.spawn(pos, bullet_dir[i])
		add_child(mob_bullet)

func veteran_shoot_bullet(pos):
	var dir = $Player.translation - pos
	dir = dir.normalized()
	var veteran_bullet = VeteranBullet.instance()
	veteran_bullet.spawn(pos, dir)
	add_child(veteran_bullet)

func _ready():
	randomize()
	for _i in range(limit):
		var bx = BigExplosion.instance()
		add_child(bx)
		big_explosion.push_back(bx)
		
		var sx = SmallExplosion.instance()
		add_child(sx)
		small_explosion.push_back(sx)

func _on_Player_destroyed(pos):
	$MobTimer.stop()
	$VeteranTimer.stop()
	get_tree().call_group("enemies", "game_over")
	spawn_big_explosion(pos)
	$UI.game_over()

func _on_Player_bullet_fired():
	$AudioManager.play_bullet_fired()
	
func _on_Player_hit(pos):
	spawn_small_explosion(pos+Vector3(0, 0, -2))

func _on_MobTimer_timeout():
	var enemy_mob = EnemyMob.instance()
	enemy_mob.spawn()
	enemy_mob.connect("shoot_bullet", self, "mob_shoot_bullet")
	enemy_mob.connect("hit", self, "spawn_small_explosion")
	enemy_mob.connect("destroyed", self, "enemy_destroyed")
	add_child(enemy_mob)

func _on_VeteranTimer_timeout():
	var enemy_veteran = EnemyVeteran.instance()
	enemy_veteran.spawn()
	enemy_veteran.connect("shoot_bullet", self, "veteran_shoot_bullet")
	enemy_veteran.connect("hit", self, "spawn_small_explosion")
	enemy_veteran.connect("destroyed", self, "enemy_destroyed")
	add_child(enemy_veteran)

	$Player.connect("player_position", enemy_veteran, "get_player_position")

func _on_play_button_pressed():
	$Player.start()
	$MobTimer.start()
	$VeteranTimer.start()

func _unhandled_key_input(_event):
	if Input.is_action_pressed("space"):
		pass
