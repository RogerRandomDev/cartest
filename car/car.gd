extends RigidDynamicBody3D

var engine=0
var steering=0;
@export var wheel_diameter=0.5;
var spin_mult=0.0;


func _ready():
	spin_mult=wheel_diameter/2/PI;


func _process(delta):
	var inp=get_inputs()
	
	
	drive_engine(inp.engine,delta)
	rotate_wheels(inp.steer,delta)
	apply_central_force(Vector3(engine*cos(-rotation.y),delta,engine*sin(-rotation.y)))
	apply_torque_impulse(Vector3(0,steering*delta*sign(engine)*5,0))
	

func get_inputs():
	var target_steer=int(Input.is_key_pressed(KEY_A))-int(Input.is_key_pressed(KEY_D))
	var target_engine=int(Input.is_key_pressed(KEY_W))-int(Input.is_key_pressed(KEY_S))
	return {"steer":target_steer*0.785398,"engine":target_engine}


func rotate_wheels(angle,delta):
	steering=lerp_angle(steering,angle,delta*10)
	$wheels.get_child(0).rotation.y=steering+1.5708
	$wheels.get_child(1).rotation.y=steering+1.5708


func drive_engine(force,delta):
	engine=lerp(engine,force*20,delta*10)
	var rolldist=Vector3($wheels/wheel.rotation.x+linear_velocity.length()*delta*sign(engine),1.5708,1.5708)
	
	for wheel in $wheels.get_children():
		wheel.rotation=rolldist


func close_normal(vel):
	var out=vel.normalized()
	var a=rotation.normalized().y
	return abs(out.x-a)<0.125||abs(out.z-a)<0.125
