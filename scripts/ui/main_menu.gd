extends Control

@onready var btn_play_local = $VBoxContainer/BtnPlayLocal
@onready var btn_how_to_play = $VBoxContainer/BtnHowToPlay
@onready var btn_settings = $VBoxContainer/BtnSettings
@onready var btn_exit = $VBoxContainer/BtnExit

var how_to_play_scene = preload("res://scenes/ui/how_to_play.tscn")
var settings_menu_scene = preload("res://scenes/ui/settings_menu.tscn")

func _ready():
	btn_play_local.pressed.connect(_on_play_local_pressed)
	btn_how_to_play.pressed.connect(_on_how_to_play_pressed)
	btn_settings.pressed.connect(_on_settings_pressed)
	btn_exit.pressed.connect(_on_exit_pressed)

func _on_play_local_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/player_lobby.tscn")

func _on_how_to_play_pressed():
	var how_instance = how_to_play_scene.instantiate()
	add_child(how_instance)

func _on_settings_pressed():
	var settings_instance = settings_menu_scene.instantiate()
	add_child(settings_instance)

func _on_exit_pressed():
	get_tree().quit()
