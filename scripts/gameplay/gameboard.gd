extends Node2D

@onready var dice_button = $HUD/BtnRollDice
@onready var pause_button = $HUD/BtnPause
@onready var turn_label = $HUD/TurnLabel

# Pemetaan Petak Tangga (Naik) dan Ular (Turun)
var snake_ladders_map = {
	# Tangga (Pangkal -> Ujung)
	4: 14,
	9: 31,
	20: 38,
	28: 84,
	40: 59,
	51: 67,
	63: 81,
	71: 91,
	# Ular (Kepala -> Ekor)
	17: 7,
	54: 34,
	62: 19,
	64: 60,
	87: 24,
	93: 73,
	95: 75,
	99: 78
}

func _ready():
	dice_button.pressed.connect(_on_roll_dice_pressed)
	pause_button.pressed.connect(_on_pause_pressed)
	update_turn_ui()

func update_turn_ui():
	var current_player = GameManager.players_data[GameManager.current_player_turn - 1]
	turn_label.text = "GILIRAN: " + str(current_player["name"])

func _on_roll_dice_pressed():
	var dice_value = randi_range(1, 6)
	print("Dadu keluar angka: ", dice_value)
	move_current_player(dice_value)

func move_current_player(steps: int):
	var current_idx = GameManager.current_player_turn - 1
	var player = GameManager.players_data[current_idx]
	var new_pos = player["position"] + steps
	
	if new_pos > 100:
		new_pos = player["position"]
	elif new_pos == 100:
		print(player["name"] + " MENANG!")
		
	if snake_ladders_map.has(new_pos):
		var destination = snake_ladders_map[new_pos]
		if destination > new_pos:
			print("MEMANJAT TANGGA dari ", new_pos, " ke ", destination)
		else:
			print("TERSERET ULAR dari ", new_pos, " ke ", destination)
		new_pos = destination
		
	player["position"] = new_pos
	print(player["name"], " sekarang berada di petak: ", new_pos)
	
	next_turn()

func next_turn():
	GameManager.current_player_turn = (GameManager.current_player_turn % GameManager.player_count) + 1
	update_turn_ui()

func _on_pause_pressed():
	print("Game Dijeda")
