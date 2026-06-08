extends VBoxContainer


@export var uis_to_hide: Array[Node] = []


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().quit_on_go_back = false


func handle_go_back() -> void:
	for ui in uis_to_hide:
		if ui.visible:
			ui.visible = false
			return
	get_tree().quit()


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_GO_BACK_REQUEST:
			handle_go_back()
