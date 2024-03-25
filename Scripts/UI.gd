extends CanvasLayer

var hp_array = Array()
@export var health_object : PackedScene
@export var full_health : Texture2D
@export var hurt_health : Texture2D
@export var badly_hurt_health : Texture2D
@export var empty_health : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in Global.player.max_health / 3:
		var h = health_object.instantiate()
		%Health.add_child(h)
		hp_array.append(h)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in hp_array.size():
		if Global.player.health <= i * 3:
			hp_array[i].texture = empty_health
		elif Global.player.health >= i * 3 + 3:
			hp_array[i].texture = full_health
		elif Global.player.health % 3 == 1:
			hp_array[i].texture = badly_hurt_health
		else:
			hp_array[i].texture = hurt_health
