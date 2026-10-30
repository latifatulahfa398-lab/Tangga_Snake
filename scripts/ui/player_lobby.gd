extends Control

@onready var btn_start = $CenterContainer/BtnStartGame
@onready var btn_back = $TopBar/BtnBack

func _ready():
	btn_start.pressed.connect(_on_start_pressed)
	btn_back.pressed.connect(_on_back_pressed)

func _on_start_pressed():
	GameManager.reset_game()
	print("Memulai Permainan TANGGA SNAKE!")
	get_tree().change_scene_to_file("res://scenes/gameplay/gameboard.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
