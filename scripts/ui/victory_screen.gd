extends Control

@onready var winner_label = $Panel/WinnerLabel
@onready var btn_play_again = $Panel/VBoxContainer/BtnPlayAgain
@onready var btn_main_menu = $Panel/VBoxContainer/BtnMainMenu

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	btn_play_again.pressed.connect(_on_play_again_pressed)
	btn_main_menu.pressed.connect(_on_main_menu_pressed)

func set_winner(winner_name: String):
	if winner_label:
		winner_label.text = "SELAMAT!\n" + winner_name + " MENANG!"

func _on_play_again_pressed():
	AudioManager.play_click()
	get_tree().paused = false
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://scenes/gameplay/gameboard.tscn")

func _on_main_menu_pressed():
	AudioManager.play_click()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
