extends Node

var player
var ui
var level
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

signal level_completed

func _ready():
	rng.randomize()
