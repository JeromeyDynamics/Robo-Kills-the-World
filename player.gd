extends CharacterBody2D

@export var speed : float = 60
@export var friction : float = 0.5

@export var dash_speed : int = 15

var can_shoot = true
var can_dash = true
var is_dashing = false
var is_dead = false
var in_water = false

var last_velocity_x
var last_velocity_y
var last_x
var last_y

@onready var camera = $Camera2D

@export var damage : int = 1
var default_damage = damage

@export var reload_speed : float = 0.1
var default_reload_speed = reload_speed

func _ready():
	Global.player = self
	
func _exit_tree():
	Global.player = null

func _physics_process(delta):
	if not is_dashing and not in_water and not is_dead:
		velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
		velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
		velocity = velocity.normalized()
		
		if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_down") or int(Input.is_action_pressed("move_up")):
			last_velocity_x = velocity.x
			last_velocity_y = velocity.y
		
		last_x = position.x
		last_y = position.y
	
	if Input.is_action_pressed("sprint"):
		speed = 850
	else:
		speed = 600
	
	
	if Input.is_action_pressed("dash") and can_dash:
		can_dash = false
		is_dashing = true
		velocity.x = last_velocity_x * dash_speed
		velocity.y = last_velocity_y * dash_speed
		$dash_duration.start()
		
	if is_dead == false:
		global_position += speed * velocity * delta
	
	if Input.is_action_pressed("shoot") and Global.node_creation_parent != null and can_shoot and is_dead == false:
		shoot()
	
	move_and_slide()

func _on_dash_cooldown_timeout():
	can_dash = true
	print("can dash")

func _on_dash_duration_timeout():
	is_dashing = false
	speed = 70
	$dash_cooldown.start()

func shoot():
	pass
