extends Spatial

var power_ups = ["rage","strength","missile","repair"]
var scene = preload("res://Power_up.tscn")

var rnd = RandomNumberGenerator.new()
func spawn():
	randomize()
	power_ups.shuffle()
	var new = scene.instance()
	new.power_name = power_ups[rnd.randi_range(0,3)]
	add_child(new)
	randomize()
	
func _ready():
	spawn()
func _on_Timer_timeout():
	spawn()
