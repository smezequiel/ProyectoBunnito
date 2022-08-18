extends Area2D



#func _on_body_entered(body):		#Aca el body es Saltarina porque es el unico que colisiona. Pero si pondriamos por ejemplo que la plataforma es un personaje apareceria tambien la colision con la plataforma. 
	#if body.name == "saltarin2": 	#Entonces especificamos que solo si es saltarin, mande la senal
		#print("Entro ", body.name)
		# Al no ser responsaiblidad de pinchos de resetear, solo le va a decir a body que le va a mandar una senal para que haga algo propio
		

export var es_trampa = false

onready var detector_personaje = $DetectorPersonaje

func _ready():
	if es_trampa:
		detector_personaje.enabled = true 
		rotation_degrees = 180

func _process(delta):
	if detector_personaje.is_colliding():
		detector_personaje.enabled = false
		detector_personaje.set_deferred("enabled", false)
		$AnimationPlayer.play("caer")
	
func _on_body_entered(body):
	body.respawn()
