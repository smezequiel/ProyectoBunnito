extends StaticBody2D



func _on_DetectorPersonaje_body_entered(body):
	$DetectorPersonaje/CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("caer")
	
func deshabilitar_colisionador():
	$Colisionador.set_deferred("disabled", true)	#para guardar memoria, si lo voy a ocupar una vez es mejor hacer esto que el onready var animacion = 
