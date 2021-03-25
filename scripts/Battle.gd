extends Node
onready var Enemy = $Enemy
onready var BattleActions = $UI/BattleActions
onready var PlayerStats = $PlayerStats

func _ready():
	start_player_turn()

func start_enemy_turn():
	BattleActions.hide()
	if Enemy != null:
		Enemy.attack(PlayerStats)
		yield(Enemy,"end_turn")
	start_player_turn()

func start_player_turn():
	BattleActions.show()
	PlayerStats.ap = PlayerStats.max_ap
	yield(PlayerStats,"end_turn")
	start_enemy_turn()


func _on_Enemy_died():
	BattleActions.hide()
	Enemy = null
