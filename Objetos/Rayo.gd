extends Area2D

export var velocidad = 400.0

onready var animacion = $Animacion

var mi_pos = Vector2.ZERO

func crear(pos):
	mi_pos = pos

func _ready():
	#global_position.x = mi_pos.x
	#global_position.y = mi_pos.y 
	#pero se resume asi:
	global_position = mi_pos
	animacion.play("moverse")
	
func _process(delta):		#esto es para que se mueva, modificando solo la posicion
	global_position.y += velocidad * delta
		

func _on_VisibilityNotifier2D_screen_exited():
	destruirse()
	
func destruirse():
	queue_free()

func _on_body_exited(body):
	if body.is_in_group("personaje"):
		body.respawn()	
	destruirse()
