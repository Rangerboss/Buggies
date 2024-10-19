extends Spatial

onready var spawners = get_parent().get_node("Player_spawners")

var player_no = 0
var players_path = []


func _ready():
	
	print(players_path)
	make_list()

func make_list():
	for spawner in spawners.get_children():
		if spawner.get_child_count()!=0:
			players_path.append("../Player_spawners/"+spawner.name+"/"+spawner.get_child(0).name)
			player_no+=1
	for spawner in spawners.get_children():
		if spawner.get_child_count()!=0:
			players_path.append("../Player_spawners/"+spawner.name+"/"+spawner.get_child(0).name)
			player_no+=1
func _physics_process(delta):
	
#	print(players_path)
	var x_sum=0
	var y_sum = 0
	var z_sum=0
	var x_avg = 0
	var y_avg = 0
	var z_avg = 0
	if players_path!=[]:
		for player in players_path:
			if get_node(player):
				x_sum+=get_node(player).translation.x
				y_sum+=get_node(player).translation.y
				z_sum+=get_node(player).translation.z
		if player_no!=0:
			x_avg = x_sum/player_no
			y_avg = y_sum/player_no
			z_avg = z_sum/player_no

		translation.x = lerp(translation.x,x_avg,0.5)
		translation.x = lerp(translation.y,y_avg,0.5)
		translation.z = lerp(translation.z,z_avg,0.5)
#	translation.z = z_avg
#	print(x_avg)
	get_child(0).look_at(Vector3(x_avg,y_avg,z_avg),Vector3.UP)
#	print(x_avg)
	pass
