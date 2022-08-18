extends "res://Juego2/Objetos/Power_Up/PowerUpBase.gd"

func aplicar_power_up(body):		#Al estar ya en el padre no es necesario volverlo a escribir, a menos que lo quiera sobreescribir
	body.volar()		#esta es una funcion que creamos en saltarin
