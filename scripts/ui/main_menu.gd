extends Control

# Ref Node Tombol UI
@onready var btn_play_local = $VBoxContainer/BtnPlayLocal
@onready var btn_how_to_play = $VBoxContainer/BtnHowToPlay
@onready var btn_settings = $VBoxContainer/BtnSettings
@onready var btn_exit = $VBoxContainer/BtnExit

func _ready():
	btn_play_local.pressed.connect(_on_play_local_pressed)
	btn_how_to_play.pressed.connect(_on_how_to_play_pressed)
	btn_settings.pressed.connect(_on_settings_pressed)
	btn_exit.pressed.connect(_on_exit_pressed)

func _on_play_local_pressed():
	print("Membuka Lobi Pemain...")
	# SceneChanger / Change scene to Lobby

func _on_how_to_play_pressed():
	print("Membuka Pop-up Cara Bermain...")

func _on_settings_pressed():
	print("Membuka Pop-up Pengaturan...")

func _on_exit_pressed():
	get_tree().quit()
