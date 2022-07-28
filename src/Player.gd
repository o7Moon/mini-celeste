extends KinematicBody2D

class_name Player

export var accel: float
export var jumpHeight: float
export var dashLength: int
export var dashStrength: float
export var coyoteFrames: int
export var friction: float
export var gravity: float
export var noDashColor: Color
export var hasDashColor: Color


var coyoteTimer: int = 0
var dashTimer: int = 0
var velocity: Vector2
var dashDirection: Vector2
var hasDash: bool = false
var deadTimer: int = 0
var waveDashFrictionMod: float = 0.0

onready var start: Vector2 = transform.origin

func _physics_process(_delta):
	$Polygon2D2.color = hasDashColor if hasDash else noDashColor
	deadTimer -= 1
	dashTimer -= 1
	coyoteTimer -= 1
	if waveDashFrictionMod > 0: waveDashFrictionMod -= 0.005
	if deadTimer == 10:
		transform.origin = start
	if deadTimer < 0:
		var wishdir: Vector2
		wishdir.x = Input.get_action_strength("right")-Input.get_action_strength("left")
		wishdir.y = Input.get_action_strength("down")-Input.get_action_strength("up")
		if dashTimer > 0:
			velocity = lerp(velocity, dashDirection*dashStrength,0.7)
			if is_on_floor() and Input.is_action_pressed("jump"):
				dashTimer = 0
				velocity.y = -jumpHeight*(1.2 if dashDirection.y < 0 else 1)
				$jump.play(0)
				velocity.x = wishdir.x * dashStrength * accel*0.2
				waveDashFrictionMod = 0.1
				hasDash = true
		else:
			velocity.x += wishdir.x*accel
			if is_on_floor(): 
				coyoteTimer = coyoteFrames
				hasDash = true
			if Input.is_action_pressed("jump") and coyoteTimer > 0:
				velocity.y = -jumpHeight
				coyoteTimer = 0
				$jump.play(0)
			velocity = velocity*(friction+waveDashFrictionMod+(0 if is_on_floor() else 0.02))
			velocity.y += gravity
			if hasDash and Input.is_action_just_pressed("dash"):
				dashTimer = dashLength
				dashDirection = wishdir
				hasDash = false
				$dash.play(0)
		velocity = move_and_slide(velocity, Vector2.UP)
		for i in get_slide_count():
			var col: KinematicCollision2D = get_slide_collision(i)
			if col.collider.get_collision_layer_bit(1):
				die()
	$deathEffect.material.set_shader_param("zoom", (deadTimer-20)*0.05)

func die()->void:
	$die.play(0)
	velocity = Vector2.ZERO
	deadTimer = 30

