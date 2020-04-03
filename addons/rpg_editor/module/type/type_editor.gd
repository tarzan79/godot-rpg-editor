tool
extends EditorPlugin

var dock_type


func _init():
    dock_type = preload("res://addons/rpg_editor/module/type/type_editor.tscn").instance()
  
