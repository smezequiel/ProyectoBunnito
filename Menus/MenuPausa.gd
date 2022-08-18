extends Control


func _ready():	#ni bien arranca el juego
	visible = false
	
func _input(event):
	if event.is_action_pressed("pausa"):
		visible = not visible
		get_tree().paused = not get_tree().paused	#esto es para sacar la pausa con la letra P


func _on_BotonContinuar_pressed():
	get_tree().paused = false
	visible = false
