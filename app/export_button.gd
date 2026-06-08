extends Button

@export var export_ui: ExportUI


func _on_pressed() -> void:
	export_ui.visible = true
