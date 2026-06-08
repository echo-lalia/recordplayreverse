extends Button

@export var info_ui: InfoUI


func _on_pressed() -> void:
	info_ui.visible = true
