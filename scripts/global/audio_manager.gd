extends Node

var bgm_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	bgm_player = AudioStreamPlayer.new()
	bgm_player.bus = &"Master"
	add_child(bgm_player)
	
	sfx_player = AudioStreamPlayer.new()
	sfx_player.bus = &"Master"
	add_child(sfx_player)

func play_bgm(stream: AudioStream):
	if stream == null: return
	if bgm_player.stream == stream and bgm_player.playing: return
	
	bgm_player.stream = stream
	bgm_player.volume_db = linear_to_db(GameManager.bgm_volume)
	bgm_player.play()

func stop_bgm():
	bgm_player.stop()

func play_sfx(stream: AudioStream):
	if stream == null: return
	sfx_player.stream = stream
	sfx_player.volume_db = linear_to_db(GameManager.sfx_volume)
	sfx_player.play()

func update_volumes():
	bgm_player.volume_db = linear_to_db(GameManager.bgm_volume)
	sfx_player.volume_db = linear_to_db(GameManager.sfx_volume)
