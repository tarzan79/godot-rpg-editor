tool
extends EditorPlugin

var dock_option
var config

signal update_bdd

func _init(config):
	print('yeah the fucking bitch 2')
	self.config = config
	dock_option = preload("res://addons/rpg_editor/module/option/option_editor.tscn").instance()
	dock_option.get_node("Panel/VBoxContainer/HBoxContainer/Button").connect("pressed", self, "_popup_bdd_sqlite")
	dock_option.get_node("Panel/VBoxContainer/HBoxContainer2/Button").connect("pressed", self, "_popup_driver_sqlite")
	dock_option.get_node("FileDialog").connect("file_selected", self, "_choose_bdd_file_sqlite")
	dock_option.get_node("FileDialog2").connect("file_selected", self, "_choose_driver_file_sqlite")
	dock_option.get_node("Panel/VBoxContainer/HBoxContainer/LineEdit").text = config.sqlite.bdd
	dock_option.get_node("Panel/VBoxContainer/HBoxContainer2/LineEdit").text = config.sqlite.driver

func _popup_bdd_sqlite():
	dock_option.get_node("FileDialog").popup()
	
func _popup_driver_sqlite():
	dock_option.get_node("FileDialog2").popup()

func _choose_bdd_file_sqlite(path):
	dock_option.get_node("Panel/VBoxContainer/HBoxContainer/LineEdit").text = path
	config.sqlite.bdd = path
	emit_signal("update_bdd")
	
func _choose_driver_file_sqlite(path):
	dock_option.get_node("Panel/VBoxContainer/HBoxContainer2/LineEdit").text = path
	config.sqlite.driver = path
	emit_signal("update_bdd")

	
	
