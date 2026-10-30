extends Control

@onready var btn_resume = $Panel/VBoxContainer/BtnResume
@onready var btn_main_menu = $Panel/VBoxContainer/BtnMainMenu

func _ready():
	btn_resume.pressed.connect(_on_resume_pressed)
	btn_main_menu.pressed.connect(_on_main_menu_pressed)

func _on_resume_pressed():
	hide()
	get_tree().paused = false

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
