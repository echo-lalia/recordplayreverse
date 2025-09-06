extends RefCounted
class_name Utils




static func show_toast(msg: String) -> void:
	var android_runtime: Object = Engine.get_singleton("AndroidRuntime")
	if android_runtime:
		var activity = android_runtime.getActivity()

		var toastCallable = func ():
			var ToastClass: JavaClass = JavaClassWrapper.wrap("android.widget.Toast")
			ToastClass.makeText(activity, msg, 1).show()

		activity.runOnUiThread(android_runtime.createRunnableFromGodotCallable(toastCallable))
	else:
		printerr("Unable to access android runtime")


### Reverse the bytes in 2byte pairs (for 16 bit data).
#static func bytes_reversed_16bit(arr: PackedByteArray) -> PackedByteArray:
	#var reversed: PackedByteArray = arr.duplicate()
	#
	#var arr_idx: int = len(arr) - 2
	#var reversed_idx: int = 0
	#while arr_idx >= 0:
		#reversed[reversed_idx] = arr[arr_idx]
		#reversed[reversed_idx + 1] = arr[arr_idx + 1] 
		#arr_idx -= 2
		#reversed_idx += 2
	#
	#return reversed
	
