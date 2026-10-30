extends Node

# State Game TANGGA SNAKE
var player_count: int = 2
var current_player_turn: int = 1
var bgm_volume: float = 1.0
var sfx_volume: float = 1.0
var flip_top_ui: bool = false

# Data Pemain (Max 4 Pemain)
var players_data = [
	{"name": "Pemain 1", "color": Color.RED, "position": 1, "is_active": true},
	{"name": "Pemain 2", "color": Color.BLUE, "position": 1, "is_active": true},
	{"name": "Pemain 3", "color": Color.GREEN, "position": 1, "is_active": false},
	{"name": "Pemain 4", "color": Color.YELLOW, "position": 1, "is_active": false}
]

func reset_game():
	current_player_turn = 1
	for p in players_data:
		p["position"] = 1
