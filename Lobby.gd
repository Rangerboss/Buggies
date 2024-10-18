extends Node2D

onready var p_list = get_node("Players_list_display")


var player_tile = preload("res://Lobby scene/Player_name.tscn")

var level_paths = []

remote func save_game_data(arr):
	PlayerData.players_data[arr[0]]=[arr[1],arr[2],arr[3],arr[4]]
#	print(PlayerData.players_data)


func _ready() -> void:
	Network.connect("update_user_list",self,"update_user_list")
	get_tree().connect("network_peer_disconnected",self,"user_left")
	get_tree().connect("connection_failed", self, "connected_fail")
	Network.create_server()
	print("Server started")
	#put our username and ID in the dictionary
	Network.user_list[str(get_tree().get_network_unique_id())] = Network.user_name

	if(get_tree().get_network_unique_id() == 1): 
		 update_user_list() 

remote func display_name(arr):
	PlayerData.players[arr[0]] = arr[1]
	for player in PlayerData.players:
		var a = player_tile.instance()
#		a.name = arr[0]
		a.text = arr[1]
		p_list.add_child(a)
	print(arr)


func update_user_list():
	for i in Network.user_list:
		var data = Network.user_list[i]


remote func send_rotation(txt):
	print(txt)

func user_left(ID):
	print(ID)
	Network.user_list.erase(str(ID)) # remove  from user_list
	update_user_list()


func _on_Create_pressed():
	Network.create_server()
	


func connected_fail():
	print("Failed to connect")
	#Connection failed so allow user to try again



func _on_Start_pressed():
	get_tree().change_scene(level_paths[0])
