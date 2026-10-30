extends Control

@onready var btn_start = $CenterContainer/VBoxContainer/BtnStartGame
@onready var btn_back = $TopBar/BtnBack
@onready var player_2_toggle = $GridContainer/CardPlayer2/CheckButton
@onready var player_3_toggle = $GridContainer/CardPlayer3/CheckButton
@onready var player_4_toggle = $GridContainer/CardPlayer4/CheckButton

func _ready():
	btn_start.pressed.connect(_on_start_pressed)
	btn_back.pressed.connect(_on_back_pressed)
	
	if player_3_toggle:
		player_3_toggle.toggled.connect(_on_p3_toggled)
	if player_4_toggle:
		player_4_toggle.toggled.connect(_on_p4_toggled)

func _on_p3_toggled(button_pressed: bool):
	GameManager.players_data[2]["is_active"] = button_pressed

func _on_p4_toggled(button_pressed: bool):
	GameManager.players_data[3]["is_active"] = button_pressed

func _on_start_pressed():
	print("Memulai Permainan TANGGA SNAKE...")
	# Transisi ke scenes/gameplay/gameboard.tscn

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
