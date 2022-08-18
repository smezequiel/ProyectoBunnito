extends Control

#lo mejor en realidad es hacer un export var y cargar la ruta

func _on_BotonIniciar_pressed():
	get_tree().change_scene("res://Juego2/Niveles/Nivel1v2.tscn")
