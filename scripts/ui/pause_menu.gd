extends Control

@onready var btn_resume = $Panel/VBoxContainer/BtnResume
@onready var btn_settings = $Panel/VBoxContainer/BtnSettings
@onready var btn_main_menu = $Panel/VBoxContainer/BtnMainMenu

var settings_menu_scene = preload("res://scenes/ui/settings_menu.tscn")

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	btn_resume.pressed.connect(_on_resume_pressed)
	btn_settings.pressed.connect(_on_settings_pressed)
	btn_main_menu.pressed.connect(_on_main_menu_pressed)

func _on_resume_pressed():
	AudioManager.play_click()
	get_tree().paused = false
	queue_free()

func _on_settings_pressed():
	AudioManager.play_click()
	var settings_instance = settings_menu_scene.instantiate()
	add_child(settings_instance)

func _on_main_menu_pressed():
	AudioManager.play_click()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
