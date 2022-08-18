extends Area2D

export(String, "oro", "plata", "bronce") var tipo_moneda

onready var animacion := $AnimatedSprite
onready var animacion_consumir := $AnimationPlayer
onready var colision_personaje := $ColisionPersonaje

#onready var c := 0			Esto lo usamos para comprobar que la moneda se consumia dos veces porque no desaparecia a tiempo

func _ready():
	animacion.play()

func _on_body_entered(_body):
	DatosPlayer.sumar_monedas(tipo_moneda)
	colision_personaje.set_deferred("disabled", true)	#Esto es para que no colisione dos veces con la moneda antes de que desaparezca
#	c += 1
	animacion_consumir.play("consumir")
	
