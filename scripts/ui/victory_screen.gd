extends Control

@onready var winner_label = $Panel/WinnerLabel
@onready var btn_play_again = $Panel/VBoxContainer/BtnPlayAgain
@onready var btn_main_menu = $Panel/VBoxContainer/BtnMainMenu

func _ready():
	btn_play_again.pressed.connect(_on_play_again_pressed)
	btn_main_menu.pressed.connect(_on_main_menu_pressed)

func set_winner(winner_name: String):
	winner_label.text = winner_name + " MENANG!"

func _on_play_again_pressed():
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://scenes/gameplay/gameboard.tscn")

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
