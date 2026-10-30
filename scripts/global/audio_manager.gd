extends Node

var bgm_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

var sound_click = preload("res://assets/audio/sfx/btn_click.wav")
var sound_dice = preload("res://assets/audio/sfx/dice_roll.wav")
var sound_ladder = preload("res://assets/audio/sfx/ladder.wav")
var sound_snake = preload("res://assets/audio/sfx/snake.wav")
var bgm_track = preload("res://assets/audio/bgm/bgm_main.wav")

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	bgm_player = AudioStreamPlayer.new()
	bgm_player.bus = &"Master"
	add_child(bgm_player)
	
	sfx_player = AudioStreamPlayer.new()
	sfx_player.bus = &"Master"
	add_child(sfx_player)
	
	call_deferred("start_default_bgm")

func start_default_bgm():
	play_bgm(bgm_track)

func play_bgm(stream: AudioStream):
	if stream == null: return
	if bgm_player.stream == stream and bgm_player.playing: return
	
	bgm_player.stream = stream
	bgm_player.volume_db = linear_to_db(GameManager.bgm_volume)
	bgm_player.play()

func play_click():
	play_sfx(sound_click)

func play_dice():
	play_sfx(sound_dice)

func play_ladder():
	play_sfx(sound_ladder)

func play_snake():
	play_sfx(sound_snake)

func play_sfx(stream: AudioStream):
	if stream == null: return
	sfx_player.stream = stream
	sfx_player.volume_db = linear_to_db(GameManager.sfx_volume)
	sfx_player.play()

func update_volumes():
	if bgm_player:
		bgm_player.volume_db = linear_to_db(GameManager.bgm_volume)
	if sfx_player:
		sfx_player.volume_db = linear_to_db(GameManager.sfx_volume)
