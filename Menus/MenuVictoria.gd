extends Control


func _ready():
	$Puntaje.text = "Tu puntaje es: {p}".format({"p": DatosPlayer.generar_puntaje()})

func _on_BotonMenuPrincipal_pressed():
	get_tree().change_scene("res://Juego2/Menus/MenuPrincipal.tscn")
