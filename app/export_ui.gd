extends ColorRect
class_name ExportUI



@export var recorder: AudioRecorder
@export var save_forward_button: Button
@export var save_backward_button: Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	visibility_changed.connect(_on_visibility_changed)



func _on_visibility_changed() -> void:
	save_forward_button.disabled = recorder.recording == null
	save_backward_button.disabled = recorder.recording == null
	OS.request_permission(("android.permission.MANAGE_EXTERNAL_STORAGE"))



func _on_save_forward_button_pressed() -> void:
	var dialog: OneshotFileDialog = OneshotFileDialog.new(Utils.get_simple_timestr() + "-forward.wav")
	dialog.done.connect(_finish_save_forward)
	add_child(dialog)

func _finish_save_forward(path: String) -> void:
	print("Save path: ", path)
	if path:
		recorder.recording.save_to_wav(path)


func _on_close_button_pressed() -> void:
	visible = false


func _on_save_backward_button_pressed() -> void:
	var dialog: OneshotFileDialog = OneshotFileDialog.new(Utils.get_simple_timestr() + "-reversed.wav")
	dialog.done.connect(_finish_save_backward)
	add_child(dialog)

func _finish_save_backward(path: String) -> void:
	print("Save path: ", path)
	if path:
		if recorder.reversed_recording == null:
			recorder._create_reversed_recording()
		recorder.reversed_recording.save_to_wav(path)
