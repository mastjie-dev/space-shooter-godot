extends Node

var sx_count = 0
var bx_count = 0

func play_bullet_fired():
	$BulletFire.play()

func play_small_explosion():
	if sx_count == 0:
		$SmallExplosion.play()
	elif sx_count == 1:
		$SmallExplosion2.play()
	else:
		$SmallExplosion3.play()
	sx_count += 1
	if sx_count == 3:
		sx_count = 0
		
func play_big_explosion():
	if bx_count == 0:
		$BigExplosion.play()
	elif bx_count == 1:
		$BigExplosion2.play()
	else:
		$BigExplosion3.play()
	bx_count += 1
	if bx_count == 3:
		bx_count = 0
