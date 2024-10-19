extends Area

var power_name = ""


func _on_Power_up_area_body_entered(body):
	if body is VehicleBody:
		body.give_power(power_name)
