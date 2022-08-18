extends KinematicBody2D

export var velocidad = 100.0		#El export era para que nos aparezca y poder modificarlo

var gravedad = 800.0 		#aumentamos la gravedad de 100 a 800 para que si cae de una plataforma trampa lo haga mas rapido
var movimiento = Vector2.ZERO

onready var animacion = $AnimatedSprite		#Esto es para que funcione la animacion
onready var detector_vacio = $DetectorVacio
onready var detector_pared = $DetectorPared

func _physics_process(_delta):
	caer()
	caminar()

	#Para que sirva la funcion tenemos que ponerla en algun lado como por ejemplo en: 
# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)

func caer():
	if not is_on_floor():
		movimiento.y = gravedad

func caminar():
	if not animacion.is_playing(): 	#"Si la animacion NO se esta ejecutando, recien ahi ejecutar la animacion de caminar"
		animacion.play("caminar")		#Acordarse que tiene qeu ser el nombre exacto
		
	
	detectar_collision()
	
	movimiento.x = velocidad
	
func detectar_collision():
		if not detector_vacio.is_colliding() or detector_pared.is_colliding():		#Si no esta colisionando con la plataforma.. 
			velocidad *= -1
			detector_vacio.position.x *= -1	
			detector_pared.scale *= -1
			detector_pared.position *= -1
			animar(animacion.flip_h)

func animar(valor_actual):
	animacion.flip_h = !valor_actual		#Va a ser lo contrario a lo que yo le este dando

func _on_DetectorJugador_body_entered(body):
	body.respawn()
