extends Area



func _on_Water_area_body_entered(body):
	if body is VehicleBody:
		body.splash_start()


func _on_Water_area_body_exited(body):
	if body is VehicleBody:
		body.splash_stop()
