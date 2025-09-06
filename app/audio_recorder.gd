extends AudioStreamPlayer
class_name AudioRecorder


## Virtual helper to access the AudioEffectRecord.
var audio_effect: AudioEffectRecord:
	get:
		return AudioServer.get_bus_effect(AudioServer.get_bus_index("Record"), 0)
	set(val):
		AudioServer.remove_bus_effect(AudioServer.get_bus_index("Record"), 0)
		AudioServer.add_bus_effect(AudioServer.get_bus_index("Record"), val)


var recording: AudioStreamWAV
var reversed_recording: AudioStreamWAV


@export var record_button: Button
@export var play_button: Button
@export var reverse_button: Button
@export var mic_input: AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	finished.connect(stop_playback)
	mic_input.finished.connect(restart_mic_input)


## Restarts on broken mic input, if needed.
func restart_mic_input() -> void:
	if not mic_input.playing:
		Utils.show_toast("Microphone input stopped. Restarting...")
		push_warning("Microphone input stopped. Restarting...")
		get_tree().reload_current_scene()


func stop_playback() -> void:
	if playing:
		playing = false
	record_button.disabled = false
	play_button.disabled = false
	reverse_button.disabled = false
	play_button.text = "Play Forward"
	reverse_button.text = "Play Reverse"


func _on_record_button_pressed() -> void:
	if audio_effect.is_recording_active():
		recording = audio_effect.get_recording()
		reversed_recording = null
		play_button.disabled = false
		reverse_button.disabled = false
		audio_effect.set_recording_active(false)
		record_button.text = "Record"
	else:
		play_button.disabled = true
		reverse_button.disabled = true
		audio_effect.set_recording_active(true)
		record_button.text = "Stop"


func _on_play_button_pressed() -> void:
	if playing:
		return stop_playback()
	record_button.disabled = true
	play_button.disabled = false
	reverse_button.disabled = true
	play_button.text = "Stop"
	
	var data = recording.get_data()
	print(data.size())
	stream = recording
	play()


func _on_play_reverse_button_pressed() -> void:
	if playing:
		return stop_playback()
	record_button.disabled = true
	play_button.disabled = true
	reverse_button.disabled = false
	reverse_button.text = "Stop"

	if reversed_recording == null:
		# Create a reverse of the recording
		var data: PackedByteArray = recording.get_data()
		var new_data: PackedByteArray = data.duplicate()
		new_data.reverse()
		reversed_recording = recording.duplicate(true)
		reversed_recording.data = new_data

	stream = reversed_recording
	play()
