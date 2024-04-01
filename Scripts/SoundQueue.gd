class_name SoundQueue
extends Node

@export var count = 1
var next = 0
var audioStreamPlayers : Array[AudioStreamPlayer]

func _ready():
	var child = get_child(0)
	
	if not child:
		print("No Child Found!")
		return
	
	if child is AudioStreamPlayer:
		for i in count:
			var duplicate = child.duplicate()
			audioStreamPlayers.append(duplicate)
			add_child(duplicate)
	else:
		print("First Child is not an AudioStreamPlayer!")

func playSound(pitch : float = 1.0, volume : float = 0.0):
	if not audioStreamPlayers[next].playing:
		audioStreamPlayers[next].pitch_scale = pitch
		audioStreamPlayers[next].volume_db = volume
		audioStreamPlayers[next].play(0.0)
		next += 1
		next %= count
		
