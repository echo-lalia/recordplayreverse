extends ColorRect
class_name InfoUI

@export var version_label: Label


func _ready() -> void:
	version_label.text = "Version: " + str(ProjectSettings.get_setting("application/config/version"))
	visible = false


func _on_close_button_pressed() -> void:
	visible = false


func _on_rich_text_label_meta_clicked(meta: Variant) -> void:
	# `meta` is not guaranteed to be a String, so convert it to a String
	# to avoid script errors at runtime.
	OS.shell_open(str(meta))
