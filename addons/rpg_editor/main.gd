tool
extends EditorPlugin
const MainPanel = preload("res://addons/rpg_editor/main.tscn")
var main_panel_instance
var panel
var db


func _enter_tree():
    db = Orm.new("sqlite")
#    _create_database_and_table()
    main_panel_instance = MainPanel.instance()
    get_editor_interface().get_editor_viewport().add_child(main_panel_instance)
    make_visible(false)
    var item_editor = load("res://addons/rpg_editor/module/item/item_editor.gd").new(db)
    main_panel_instance.get_node("TabContainer/Objet").add_child(item_editor.dock_item)
    
    var type_editor = load("res://addons/rpg_editor/module/type/type_editor.gd").new()
    main_panel_instance.get_node("TabContainer/Type").add_child(type_editor.dock_type)
    
#    var option_editor = load("res://addons/rpg_editor/module/option/option_editor.gd").new()
#    main_panel_instance.get_node("TabContainer/Option").add_child(option_editor.dock_option)
#    option_editor.connect("update_bdd", self, "_update_bdd")


func _exit_tree():
   main_panel_instance.queue_free()

func has_main_screen():
   return true

func make_visible(visible):
   if visible:
      main_panel_instance.show()
   else:
      main_panel_instance.hide()

func get_plugin_name():
   return "RPG Editor"


#func _create_database_and_table():
#    var query
#    query = "CREATE TABLE IF NOT EXISTS items ("
#    query += "id integer PRIMARY KEY,"
#    query += "sprite text NOT NULL,"
#    query += "region text,"
#    query += "name text NOT NULL UNIQUE,"
#    query += "desc text NOT NULL,"
#    query += "type INT NOT NULL,"
#    query += "price text NOT NULL"
#    query += ");"
#    sqlite.query(query)

