extends Node2D

@onready var dice_button = $HUD/BtnRollDice
@onready var pause_button = $HUD/BtnPause
@onready var turn_label = $HUD/TurnLabel

var pause_menu_scene = preload("res://scenes/ui/pause_menu.tscn")
var victory_screen_scene = preload("res://scenes/ui/victory_screen.tscn")
var pause_menu_instance = null

# Pengaturan Koordinat Grid Papan (10x10)
var board_origin = Vector2(340, 630) # Titik awal petak 1 (Kiri Bawah)
var tile_size = Vector2(60, 58)      # Ukuran per petak

var player_nodes = []
var is_moving = false

var snake_ladders_map = {
	4: 14, 9: 31, 20: 38, 28: 84, 40: 59, 51: 67, 63: 81, 71: 91,
	17: 7, 54: 34, 62: 19, 64: 60, 87: 24, 93: 73, 95: 75, 99: 78
}

var player_colors = [
	Color(0.9, 0.2, 0.2), # Merah
	Color(0.2, 0.5, 0.9), # Biru
	Color(0.2, 0.8, 0.2), # Hijau
	Color(0.9, 0.8, 0.1)  # Kuning
]

func _ready():
	dice_button.pressed.connect(_on_roll_dice_pressed)
	pause_button.pressed.connect(_on_pause_pressed)
	spawn_player_tokens()
	update_turn_ui()

func spawn_player_tokens():
	for i in range(GameManager.player_count):
		var token = ColorRect.new()
		token.custom_minimum_size = Vector2(24, 24)
		token.color = player_colors[i]
		token.pivot_offset = Vector2(12, 12)
		
		# Set offset kecil agar bidak tidak menumpuk persis di titik sama
		var offset = Vector2((i % 2) * 14 - 7, (i / 2) * 14 - 7)
		token.position = get_tile_position(1) + offset - Vector2(12, 12)
		
		add_child(token)
		player_nodes.append(token)

func get_tile_position(tile_num: int) -> Vector2:
	var index = tile_num - 1
	var row = index / 10
	var col = index % 10
	
	# Baris ganjil berarah balik (Zig-zag 1-10 kiri->kanan, 11-20 kanan->kiri)
	if row % 2 == 1:
		col = 9 - col
		
	var x = board_origin.x + (col * tile_size.x)
	var y = board_origin.y - (row * tile_size.y)
	return Vector2(x, y)

func update_turn_ui():
	var current_player = GameManager.players_data[GameManager.current_player_turn - 1]
	turn_label.text = "GILIRAN: " + str(current_player["name"])

func _on_roll_dice_pressed():
	if is_moving:
		return
		
	is_moving = true
	dice_button.disabled = true
	
	var dice_value = randi_range(1, 6)
	print("Dadu keluar angka: ", dice_value)
	await move_current_player_animated(dice_value)
	
	dice_button.disabled = false
	is_moving = false

func move_current_player_animated(steps: int):
	var current_idx = GameManager.current_player_turn - 1
	var player = GameManager.players_data[current_idx]
	var token_node = player_nodes[current_idx]
	var start_pos = player["position"]
	var target_pos = start_pos + steps
	
	if target_pos > 100:
		target_pos = start_pos
	
	# Animasi melompat petak demi petak
	for step in range(start_pos + 1, target_pos + 1):
		player["position"] = step
		var target_coord = get_tile_position(step) + Vector2((current_idx % 2) * 14 - 7, (current_idx / 2) * 14 - 7) - Vector2(12, 12)
		
		var tween = create_tween()
		tween.tween_property(token_node, "position", target_coord, 0.25).set_trans(Tween.TRANS_SINE)
		await tween.finished
	
	# Cek perosotan Ular / tangga
	if snake_ladders_map.has(target_pos):
		var destination = snake_ladders_map[target_pos]
		player["position"] = destination
		var dest_coord = get_tile_position(destination) + Vector2((current_idx % 2) * 14 - 7, (current_idx / 2) * 14 - 7) - Vector2(12, 12)
		
		var tween = create_tween()
		tween.tween_property(token_node, "position", dest_coord, 0.5).set_trans(Tween.TRANS_CUBIC)
		await tween.finished

	if player["position"] >= 100:
		show_victory(player["name"])
	else:
		next_turn()

func next_turn():
	GameManager.current_player_turn = (GameManager.current_player_turn % GameManager.player_count) + 1
	update_turn_ui()

func _on_pause_pressed():
	if pause_menu_instance == null:
		pause_menu_instance = pause_menu_scene.instantiate()
		add_child(pause_menu_instance)
	else:
		pause_menu_instance.show()
	get_tree().paused = true

func show_victory(winner_name: String):
	var victory_instance = victory_screen_scene.instantiate()
	add_child(victory_instance)
	victory_instance.set_winner(winner_name)
