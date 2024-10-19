extends Spatial

onready var area = get_node("Area")

var shoot =false


func _physics_process(delta):
	if shoot == true:
		visible=true
		global_transform.basis.z+=Vector3(0,0,delta*1)
		shoot =false

func shoot():
	shoot =true


func _on_Area_body_entered(body):
	if shoot ==true:
		if body is VehicleBody:
			body.health-=40
			visible=false
			global_transform.basis.x = Vector3(-5.11,0,0)
		
