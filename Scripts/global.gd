extends Node

var player
var score = 0
var ui
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
