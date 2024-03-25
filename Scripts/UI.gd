extends CanvasLayer

var hp_array = Array()
@export var health_object : PackedScene
@export var full_health : Texture2D
@export var hurt_health : Texture2D
@export var badly_hurt_health : Texture2D
@export var empty_health : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ui = self
	for i in Global.player.max_health / 3:
		var h = health_object.instantiate()
		%Health.add_child(h)
		hp_array.append(h)

func emit_damage_particles():
	var h = hp_array[ceil(Global.player.health / 3.0) - 1].find_child("GPUParticles2D")
	h.restart()
	for i in hp_array.size():
		var f = Global.rng.randf_range(-10,10)
		hp_array[i].position.y += f
		var tween = create_tween().bind_node(self)
		tween.tween_property(hp_array[i], "position", hp_array[i].position - Vector2(0,f), 0.1)

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
