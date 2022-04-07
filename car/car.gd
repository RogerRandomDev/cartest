extends RigidDynamicBody3D

var engine=0
var steering=0;

func _process(delta):
	var inp=get_inputs()
	
	rotate_wheels(inp.steer,delta)
	drive_engine(inp.engine,delta)



func get_inputs():
	var target_steer=int(Input.is_key_pressed(KEY_A))-int(Input.is_key_pressed(KEY_D))
	var target_engine=int(Input.is_key_pressed(KEY_W))-int(Input.is_key_pressed(KEY_S))
	return {"steer":target_steer*0.785398,"engine":target_engine}


func rotate_wheels(angle,delta):
	steering=lerp_angle(steering,angle,delta*10)
	$wheels.get_child(0).rotation.y=steering
	$wheels.get_child(1).rotation.y=steering


func drive_engine(force,delta):
	engine=lerp(engine,force,delta*10)
