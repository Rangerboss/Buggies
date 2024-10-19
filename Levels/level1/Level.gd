extends Spatial


var car_scene = preload("res://Car.tscn")
onready var spawners = get_node("Player_spawners")
#var rnd = RandomNumberGenerator.new()
remote func save_game_data(arr):
	PlayerData.players_data[arr[0]]=[arr[1],arr[2],arr[3],arr[4]]
var spawns = []

func _ready():
	for i in spawners.get_child_count():
		spawns.append("Spawner"+str(i+1))
	for id in PlayerData.players.keys():
		var new_car = car_scene.instance()
		new_car.name = str(id)
		spawns.shuffle()
		spawners.get_node(spawns[0]).add_child(new_car)
		spawns.pop_front()
		
func _physics_process(delta):
	
#	for player_id in PlayerData.players_data.keys():
#		var loc_player = spawners.get_node(str(player_id))
#		loc_player.is_acc = PlayerData.players_data[player_id][1]
#		loc_player.is_brake = PlayerData.players_data[player_id][2]
#		loc_player.is_acc = PlayerData.players_data[player_id][1]
	pass
