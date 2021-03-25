extends Node2D

var hp = 25 setget set_hp
var target = null

onready var HPLabel = $HPLabel
onready var AnimPlayer = $AnimationPlayer

signal died
signal end_turn

func set_hp(new_hp):
	hp = new_hp
	HPLabel.text = str(hp)+ " hp"

func attack(target):
	yield(get_tree().create_timer(0.4),"timeout")
	AnimPlayer.play("attack")
	self.target = target
	yield(AnimPlayer,"animation_finished")
	self.target = null
	emit_signal("end_turn")

func deal_damage():
	self.target.hp -= 4

func take_damage(amount):
	self.hp -= amount
	if is_dead():
		queue_free()
		emit_signal("died")
	else:
		AnimPlayer.play("shake")

func is_dead():
	return hp <= 0
