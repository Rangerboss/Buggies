extends Spatial

onready var spawners = get_parent().get_node("Player_spawners")

var player_no = 0
var players_path = []


func _ready():
	for spawner in spawners.get_children():
		if spawner.get_child_count()!=0:
			players_path.append("../Player_spawner/"+spawner.name+get_child(0).name)
			player_no+=1
	
		
func _physics_process(delta):
#	var x_sum=0
#	var z_sum=0
#	var x_avg = 0
#	var z_avg = 0
#
#	for player in players_path:
#		x_sum+=get_node(player).translation.x
#		z_sum+=get_node(player).translation.z
#	if player_no!=0:
#		x_avg = x_sum/player_no
#		z_avg = z_sum/player_no
#
#	translation.x = x_avg
#	translation.z = z_avg
#	print(x_avg)
	pass
