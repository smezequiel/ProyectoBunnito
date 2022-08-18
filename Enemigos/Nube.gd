extends Node2D

onready var detector_jugador = $Sprite/RayCast2D
onready var posiciones_disparo = $Sprite/PosicionesDisparo
onready var cadencia_disparo = $Timer
onready var sfx_rayos = $Rayos

export var rayo: PackedScene	#aca esta guardada nomas

var puede_disparar = true

func _process(_delta):
	if detector_jugador.is_colliding() and puede_disparar:
		disparar()
		puede_disparar = false		#si queda asi dispara una sola vez y ya esta
		cadencia_disparo.start()		#esto es para resetear el timer

func disparar():	#quiero que dispare una instancia 
	sfx_rayos.play()
	for posicion in posiciones_disparo.get_children(): #porque son hijas de posicion disparo
		var nuevo_rayo = rayo.instance()
		nuevo_rayo.crear(posicion.global_position)
		owner.get_node("Rayos").add_child(nuevo_rayo)

func _on_Timer_timeout():
	puede_disparar = true		#aca va a quedar en cero y tendria que manualmente reiniciar el timer
