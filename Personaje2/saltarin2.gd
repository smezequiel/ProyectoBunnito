extends KinematicBody2D

export var velocidad = Vector2(150.0, 150.0)
export var acel_caida = 400				#Una aceleracion baja caeria muuuy lentamente
export var fuerza_salto = 3000
export var fuerza_rebote = 350
export var impulso = -3800

var movimiento = Vector2.ZERO
var fuerza_salto_original
var acel_caida_original
var puede_moverse = true

onready var animacion = $Animacion
onready var audio_salto = $AudioSalto
onready var camara = $Camera2D
onready var acabar_powerup_salto = $AcabarPowerUpSalto
onready var acabar_powerup_volar = $AcabarPowerUpVolar
onready var animacion_personaje = $AnimationPlayer

func _ready(): 
	animacion_personaje.play("aclarar")
	fuerza_salto_original = fuerza_salto
	acel_caida_original = acel_caida

func _physics_process(_delta):
	movimiento.x = velocidad.x * tomar_direccion()
	
	caer()
	saltar()
	collision_techo()
	caida_vacio()
	

# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)

func tomar_direccion():
	var direccion = 0
	if puede_moverse:
		direccion = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		if direccion == 0:
			animacion.play("idle")
		else:
			if direccion < 0: 	#significa que vamos a la izquierda
				animacion.flip_h = true
			else:
				animacion.flip_h = false
				
			animacion.play("correr")
	
	return direccion


func caer():
	if not is_on_floor():
		animacion.play("saltar")
		movimiento.y += acel_caida			#Esto solo hace que la caida vaya en aumento
		movimiento.y = clamp(movimiento.y, impulso, velocidad.y)
	
func saltar():
	if Input.is_action_just_pressed("saltar") and is_on_floor() and puede_moverse:			#Si no aclaramos lo de is_on_floor va a saltar y quedar ahi
		animacion.play("saltar")
		audio_salto.play()
		saltar_movimiento()

func saltar_movimiento(): 		#esto es para de alguna manera saltar sin tener que apretar
	movimiento.y = 0		#Yo defini que tenga una fuerza de gravedad de 800, pero con esto en el instante del salto no tengo que vencer esos 800
	movimiento.y -= fuerza_salto
		
		
func collision_techo():
	if is_on_ceiling():
		movimiento.y = fuerza_rebote

func cambiar_fuerza_salto():		#esto lo creamos para el powerUp
	acabar_powerup_salto.start()		#activamos el timer
	fuerza_salto = -impulso * 0.9
	

func impulsar():
	movimiento.y = impulso

func volar():	#lo creamos para el power up de volar
	acabar_powerup_volar.start()
	acel_caida = 60		#probamos para que de la sensacion de volar
	animacion_personaje.play("Volar")
	saltar_movimiento()
	
func respawn():
	DatosPlayer.restar_vidas()
	animacion_personaje.play("oscurecer")
	if DatosPlayer.vidas != 0:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

func caida_vacio():
	if position.y > camara.limit_bottom:
		respawn()

func _on_AcabarPowerUp_timeout():
	fuerza_salto = fuerza_salto_original


func _on_AcabarPowerUpVolar_timeout():
	animacion_personaje.play("default")
	acel_caida = acel_caida_original


func play_entrar_portal(posicion_portal):
	puede_moverse = false
	animacion_personaje.play("entrar_portal")
	$Tween.interpolate_property(#pide 7 parametros
		self,	#sobre que objeto se esta trabajando
		"global_position", #que propiedad queremos modificar de este objeto en forma de string
		global_position, #el valor donde este saltarina en este momento. ej: 0
		posicion_portal, #a donde quiero ir. ej: 100
		0.8, #en que tiempo
		Tween.TRANS_LINEAR, #tipo de transicion. JUGAR
		Tween.EASE_OUT_IN #velocidad de transporlacion, aca es mas lenta en los extremos. JUGAR
	)
	$Tween.start()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "entrar_portal":
		animacion_personaje.play("oscurecer")
	
