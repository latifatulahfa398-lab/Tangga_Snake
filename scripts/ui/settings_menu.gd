extends Control

@onready var btn_close = $Panel/BtnClose
@onready var bgm_slider = $Panel/VBoxContainer/HBoxBGM/BGMSlider
@onready var sfx_slider = $Panel/VBoxContainer/HBoxSFX/SFXSlider

func _ready():
	btn_close.pressed.connect(_on_close_pressed)
	bgm_slider.value_changed.connect(_on_bgm_changed)
	sfx_slider.value_changed.connect(_on_sfx_changed)
	
	bgm_slider.value = GameManager.bgm_volume
	sfx_slider.value = GameManager.sfx_volume

func _on_bgm_changed(value: float):
	GameManager.bgm_volume = value

func _on_sfx_changed(value: float):
	GameManager.sfx_volume = value

func _on_close_pressed():
	queue_free()
