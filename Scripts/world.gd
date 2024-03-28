extends Node2D

@export var time = 150
@export var next_level : PackedScene
@export var level_name : String
@export var level_description : String
@onready var level_timer = $LevelTimer
var score = 0

var eggs_collected = {
	"blue" = false,
	"green" = false,
	"red" = false,
	"yellow" = false
}

func _ready():
	Global.level = self
	level_timer.start(time)
	Global.level_completed.connect(levelCompleted)

func levelCompleted():
	get_tree().paused = true
	Global.ui.animation_player.play("level_complete")
	await Global.ui.animation_player.animation_finished
	if not next_level is PackedScene: return
	Global.ui.animation_player.play("transition_in")
	await Global.ui.animation_player.animation_finished
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)
