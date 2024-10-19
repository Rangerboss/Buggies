extends Spatial

var power_name = ""


func _ready():
	get_node("Power_up_area").power_name=power_name

	if power_name == "rage":
		get_node("Icon").material_override.set("albedo_texture", load("res://Textures/Power_ups/rage-removebg-preview.png"))
	elif power_name == "strength":
		get_node("Icon").material_override.set("albedo_texture", load("res://Textures/Power_ups/strength.png"))
	elif power_name == "missile":
		get_node("Icon").material_override.set("albedo_texture", load("res://Textures/Power_ups/ballastic_missile-removebg-preview.png"))
	elif power_name == "repair":
		get_node("Icon").material_override.set("albedo_texture", load("res://Textures/Power_ups/repair_-removebg-preview.png"))
