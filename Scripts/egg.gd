extends PickUp

@export var speed = 150.0
var follow_target = null
var disabled_pickup = false

func _physics_process(delta):
	if disabled_pickup:
		var distance_to_target = global_position.distance_to(follow_target.global_position)
		if distance_to_target > 16:
			global_position = global_position.move_toward(follow_target.global_position, speed * (distance_to_target / 32) * delta)

func disable_pickup(body):
	if body is Player:
		follow_target = body.egg_chain.back() if body.egg_chain.back() else body
		body.egg_chain.append(self)
	super.disable_pickup(body)
	disabled_pickup = true
