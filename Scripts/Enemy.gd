extends CharacterBody2D

@export var points = 100
@export var speed = 50.0
@export var max_health = 1
@export var bounce_scale = 1.0
@export var flying = false
@export var checks_floor = false
@export var invincible = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health = max_health
var is_moving = true
var direction = Vector2.RIGHT

func _ready():
	$AnimatedSprite2D.play("move")

func _physics_process(delta):
	if is_moving: 
		velocity.x = direction.x * speed
	else:
		velocity.x = 0
	if not flying and not is_on_floor(): velocity.y += gravity * delta
	move_and_slide()
	if is_on_wall(): change_direction()

func change_direction():
	direction = -direction
	$AnimatedSprite2D.flip_h = (sign(direction.x) == -1)
	$FloorCheck/CollisionShape2D.position.x = -$FloorCheck/CollisionShape2D.position.x

func die():
	set_collision_layer_value(3,false)
	$PlayerCheck.set_collision_layer_value(4,false)
	is_moving = false
	$AnimatedSprite2D.play("death")
	Global.score += points

func hurt():
	is_moving = false
	$AnimatedSprite2D.play("hurt")
	if $AnimatedSprite2D.frame > 0: $AnimatedSprite2D.frame = 0

func damage():
	if not invincible: health -= 1
	if health <= 0:
		die()
	else:
		hurt()

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "death": queue_free()
	if $AnimatedSprite2D.animation == "hurt":
		is_moving = true
		$AnimatedSprite2D.play("move")

func _on_floor_check_body_exited(body):
	if checks_floor:
		change_direction()
