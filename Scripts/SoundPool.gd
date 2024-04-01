extends Node

var sounds : Array[SoundQueue]
var last_index = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_children().size():
		sounds.append(get_child(i))

func playRandomSound(pitch : float = 1.0, volume : float = 0.0):
	var index = Global.rng.randi_range(0, sounds.size() - 1)
	while index == last_index:
		index = Global.rng.randi_range(0, sounds.size() - 1)
	
	sounds[index].playSound(pitch,volume)
