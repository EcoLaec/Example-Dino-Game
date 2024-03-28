extends PickUp

@export_enum("blue", "green", "red", "yellow") var egg_color: String = "green"

func _ready():
	super._ready()
	$AnimatedSprite2D.play(egg_color)
	print(egg_color)

func pickup(body):
	Global.level.eggs_collected[egg_color] = true
	if Global.level.eggs_collected.values().all(func(e): return e): Global.level_completed.emit()
	super.pickup(body)
