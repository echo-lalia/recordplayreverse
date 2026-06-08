extends FileDialog
class_name OneshotFileDialog


var is_done: bool = false
signal done(path: String)


func _init(default: String = "") -> void:
	if default:
		current_path = "/storage/emulated/0/Download/" + default
	file_mode = FileDialog.FILE_MODE_SAVE_FILE
	display_mode = FileDialog.DISPLAY_LIST
	access = FileDialog.ACCESS_FILESYSTEM
	filters = PackedStringArray(["*.wav;Wave Files;audio/wav"])
	use_native_dialog = true
	mode = Window.MODE_MAXIMIZED
	
	file_selected.connect(_on_file_selected)
	canceled.connect(_on_cancel)
	
	visible = true


func _on_file_selected(path: String) -> void:
	visible = false
	is_done = true
	done.emit(path)
	queue_free()


func _on_cancel() -> void:
	visible = false
	is_done = true
	done.emit("")
	queue_free()
	


func _exit_tree() -> void:
	if not is_done:
		is_done = true
		done.emit("")
	
