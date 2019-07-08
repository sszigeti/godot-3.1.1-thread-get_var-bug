extends Control

const TEST_FILE_NAME := "res://tesfile.res"
onready var label:Label = $MarginContainer/VBoxContainer/HBoxContainer/StoredVarValue
onready var ok:ColorRect = $MarginContainer/VBoxContainer/HBoxContainer/ColorRect

var _thread := Thread.new()
var test_var


func _ready() -> void:
	assert _thread.start(self, "_load_data") == OK


# Below function was used to create the test file. It is currently not used in this demo, but can easily be attached to a button or called in _ready.
func _create_test_file() -> void:
	var f:File = File.new()
	assert f.open(TEST_FILE_NAME, File.WRITE) == OK
	var test:String = "Persisted variable value"
	f.store_var(test)
	f.close()


func _load_data(_ignore_unused_thread_arg) -> void:
	var f:File = File.new()
	assert f.open(TEST_FILE_NAME, File.READ) == OK
	test_var = f.get_var()
	f.close()
	call_deferred("_load_data_done")


func _load_data_done() -> void:
	_thread.wait_to_finish()
	var has_value:bool = test_var != null
	label.visible = has_value
	label.text = "[%s]" % test_var if test_var else "ERROR: NO DATA"
	print("Test var: [%s]" % test_var)
	ok.show()
