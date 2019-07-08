This Godot3.1.1 project demonstrates the following bug:

A variable was persisted using `File.store_var` in the `res://testfile.res` file.

A threaded function is used to retrieve the value of the variable. This is working perfectly in the editor, and also in a debug export, but it completely fails in a non-debug export.
