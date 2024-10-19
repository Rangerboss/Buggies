extends VehicleBody

# ------------------------------------------------
# Script author: Bastiaan Olij, modified by Warrpy
# ------------------------------------------------

############################################################
# behaviour values


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

############################################################
# Input

export var joy_steering = JOY_ANALOG_LX
export var steering_mult = -1.0
export var joy_throttle = JOY_ANALOG_R2
export var throttle_mult = 1.0
export var joy_brake = JOY_ANALOG_L2
export var brake_mult = 1.0
var steer_val = 0
var throttle_val = 0
var brake_val = 0

func _ready():
	pass

func _physics_process(delta):
#	print(PlayerData.players_data)
	if PlayerData.players_data.has(int(name)):
		steer_val = -1*PlayerData.players_data[int(name)][0]
#		print(steer_val)
	#	var throttle_val = throttle_mult * Input.get_joy_axis(0, joy_throttle)
	#	var brake_val = brake_mult * Input.get_joy_axis(0, joy_brake)
		
		is_acc = PlayerData.players_data[int(name)][1]
		is_brake = PlayerData.players_data[int(name)][2]
	
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
