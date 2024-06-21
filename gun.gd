extends Node2D

var bullet = preload("res://bullet.tscn")

@export var radius : int = 5

var can_shoot = true

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
	if Input.is_action_pressed("shoot") and can_shoot:
		var bullet_instance = Global.instance_node(bullet, global_position, Global.node_creation_parent)
		bullet_instance.position = $bulletPoint.get_global_position()
		can_shoot = false
		$reload_time.start()
	
func _on_reload_time_timeout():
	can_shoot = true
