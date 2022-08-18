extends Node
signal abrir_portal()		#aca estoy haciendo una senal que luego la voy a conectar con portal

export var menu_game_over = "res://Juego2/Menus/MenuGameOver.tscn"
export var nivel_actual = ""

var numero_llaves = 0
var contenedor_llaves

onready var nubes_lejanas = $ParallaxBackground/ParallaxNubesLejanas

func _ready():
# warning-ignore:return_value_discarded
	DatosPlayer.connect("game_over", self, "game_over")
	contenedor_llaves = get_node_or_null("Zanahorias")		#busca, si no hay no tira error
	if contenedor_llaves != null:
		numero_llaves_nivel()
	
#func _process(delta):
#	nubes_lejanas.motion_offset.x -= 5 	#esto es para que las nubes se muevan hacia la izquierda	
# lo borramos porque si nos movemos hacia la izquierda, va bien, pero si vamos a la derecha las nubes se quedan quietas

func numero_llaves_nivel():
	numero_llaves = contenedor_llaves.get_child_count()		#contabiliza las hijas que haya, pero no diferencia zanahorias de monedas
	DatosPlayer.contabilizar_llaves(numero_llaves)
	for llave in contenedor_llaves.get_children():
		llave.connect("consumida", self, "llaves_restantes")	#nos pide que senal vamos a conectar, con quien y con cual de mis metodos quiero conectarlo
		#por cada hijo que encuentre en el contenedor que le dijimos que se llamaba Zanahorias va a conectar la senal consunmida con el metodo llaves_restantes
		
		
func llaves_restantes():
	numero_llaves -= 1
	if numero_llaves == 0:
		emit_signal("abrir_portal")


func game_over():
	DatosPlayer.nivel_actual = nivel_actual
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_game_over)
