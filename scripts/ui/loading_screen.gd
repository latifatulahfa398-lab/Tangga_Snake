extends Control

@onready var progress_bar = $Panel/ProgressBar
@onready var status_label = $Panel/StatusLabel

var tips = [
	"Menyiapkan papan TANGGA SNAKE...",
	"Membangunkan ular...",
	"Memoles anak tangga...",
	"Menyiapkan dadu keberuntungan..."
]

func _ready():
	progress_bar.value = 0
	animate_loading()

func animate_loading():
	var tween = create_tween()
	
	for i in range(tips.size()):
		var target_val = (i + 1) * 25.0
		status_label.text = tips[i]
		tween.tween_property(progress_bar, "value", target_val, 0.6).set_trans(Tween.TRANS_SINE)
		tween.tween_interval(0.2)
		
	await tween.finished
	
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
