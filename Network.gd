extends Node

signal update_user_list

var user_name : String = "Noob"
var user_rotation : float = 0.0

var user_list : Dictionary

func _ready() -> void:
	get_tree().connect("connected_to_server",self,"connected")
	get_tree().connect("server_disconnected",self,"server_disconnected")





#func connected():
#	print("connected to server")
#	var compile_data : Array = [str(get_tree().get_network_unique_id()),user_name]
#	rpc_unreliable_id(1,"update_user",compile_data)

	
#Only run on the server
remote func update_user(user):
	user_list[str(user[0])] = user[1]
	emit_signal("update_user_list")
	rpc_unreliable("client_update",user_list)

	pass
	
remote func client_update(update_user_list):
	user_list = update_user_list
	print(user_list)
	emit_signal("update_user_list")

#Server just closed
func server_disconnected():
	print("server_disconnected")
	OS.alert('Server closed', 'Status')
#	get_tree().change_scene("res://Lobby.tscn")
	

func create_server():
	var server : NetworkedMultiplayerENet = NetworkedMultiplayerENet.new()
	server.create_server(9999,4)
	get_tree().set_network_peer(server)

#
#func enter_chat_room():
#	get_tree().change_scene("res://ChatRoom/Chatroom.tscn")
