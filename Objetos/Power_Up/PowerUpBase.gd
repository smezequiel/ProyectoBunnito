extends Area2D

onready var animacion = $AnimationPlayer
onready var detector_personaje = $CollisionShape2D


func _on_body_entered(body):
	aplicar_power_up(body)
	detector_personaje.set_deferred("disabled", true)		#esto es para que no colisione mas con el personaje
	animacion.play("Consumir")

func aplicar_power_up(body):
	pass
	
