extends Control

@onready var btn_close = $Panel/BtnClose

func _ready():
	btn_close.pressed.connect(_on_close_pressed)

func _on_close_pressed():
	queue_free()
