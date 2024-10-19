extends VehicleBody

# ------------------------------------------------
# Script author: Bastiaan Olij, modified by Warrpy
# ------------------------------------------------

############################################################
# behaviour values

var health = 100

var attack_streangth = 10
var in_water = false
var is_acc = false
var is_brake = false
var gyro = 0.0
var is_power_up = false

export var MAX_ENGINE_FORCE = 200.0
export var MAX_BRAKE_FORCE = 5.0
export var MAX_STEER_ANGLE = 0.5

export var steer_speed = 5.0

var steer_target = 0.0
var steer_angle = 0.0
var power_name = ""
############################################################
# Input

export var joy_steering = JOY_ANALOG_LX
export var steering_mult = -1.0
export var joy_throttle = JOY_ANALOG_R2
export var throttle_mult = 1.0
export var joy_brake = JOY_ANALOG_L2
export var brake_mult = 1.0

onready var name_tag = get_node("Name_tag")

func _ready():
	name_tag.text = PlayerData.players[int(name)]

func splash_start():
	get_node("Water_splash").emitting = true
func splash_stop():
	get_node("Water_splash").emitting = false

func _physics_process(delta):
	
	name_tag.get_child(0).mesh.set("size",Vector2(health*2.274/100,0.225))
	
	var steer_val = 0
	var throttle_val = 0
	var brake_val = 0
#	print(PlayerData.players_data)
	if PlayerData.players_data.has(int(name)):
		steer_val = -1*PlayerData.players_data[int(name)][0]
#		print(steer_val)
	#	var throttle_val = throttle_mult * Input.get_joy_axis(0, joy_throttle)
	#	var brake_val = brake_mult * Input.get_joy_axis(0, joy_brake)
		
		is_acc = PlayerData.players_data[int(name)][1]
		is_brake = PlayerData.players_data[int(name)][2]
		if PlayerData.players_data[int(name)][3]==true:
			enable_power()
	if is_acc:
		throttle_val = 1.0
	if is_brake:
		throttle_val = -1.0
#	if Input.is_action_pressed("ui_accept"):
#		brake_val = 1.0
#	if Input.is_action_pressed("ui_left"):
#		steer_val = 1.0
#	if Input.is_action_pressed("ui_right"):
#		steer_val = -1.0
	
	engine_force = throttle_val * MAX_ENGINE_FORCE
	brake = brake_val * MAX_BRAKE_FORCE
	
	steer_target = steer_val * MAX_STEER_ANGLE
	if (steer_target < steer_angle):
		steer_angle -= steer_speed * delta
		if (steer_target > steer_angle):
			steer_angle = steer_target
	elif (steer_target > steer_angle):
		steer_angle += steer_speed * delta
		if (steer_target < steer_angle):
			steer_angle = steer_target
	steering = steer_angle
	



func enable_power():
	if power_name == "rage":
		get_node("Rage_timer").start()
		MAX_ENGINE_FORCE=400
	elif power_name=="repair":
		health = 100
	elif power_name=="strength":
		attack_streangth=30
		get_node("Strength_timer").start()
	elif power_name == "missile":
		get_node("missile").visible = true
		get_node("missile/missile_bullet").shoot = true

func give_power(power):
	power_name=power


func _on_Rage_timer_timeout():
	MAX_ENGINE_FORCE=200


func _on_Strength_timer_timeout():
	attack_streangth=10
