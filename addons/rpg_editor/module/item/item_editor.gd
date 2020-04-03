tool
extends EditorPlugin

var dock_item
var db

func _init(db):
    self.db = db
    dock_item = preload("res://addons/rpg_editor/module/item/item_editor.tscn").instance()
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer/Button").connect("pressed", self, "_open_file")
    dock_item.get_node("FileDialog").connect("file_selected", self, "_edit_file_path")
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer2/Button").connect("pressed", self, "new_item")
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer2/Button2").connect("pressed", self, "save_item")
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer2/Button3").connect("pressed", self, "del_item")
    
    var dropdown = dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer3/OptionButton")
    dropdown.add_item("objet")
    dropdown.add_item("arme")
    
    list_item()
    dock_item.get_node("HBoxContainer2/Panel/ItemList").connect("item_selected", self, "_show_item")
    #item_selected

#affiche tout les items dans la liste
func list_item():
    var itemlist = dock_item.get_node("HBoxContainer2/Panel/ItemList")
    itemlist.clear()
    var items = db.select("items").find()
    for i in items:
        itemlist.add_item(i.name)
        
func _show_item(id):
    var s = dock_item.get_node("HBoxContainer2/Panel/ItemList").get_item_text(id)
    var item = db.select("items").find({"name": s})
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer7/LineEdit").text = str(item[0].id)
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer/LineEdit").text = item[0].sprite
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer2/LineEdit").text = item[0].name
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer3/OptionButton").selected = item[0].type
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer4/LineEdit").text = item[0].price
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer6/TextEdit").text = item[0].desc
    show_image_item()
    
func _open_file():
    dock_item.get_node("FileDialog").popup()
    
func _edit_file_path(path):
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer/LineEdit").text = path
    show_image_item()
    
func new_item():
    console.info("new item")
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer/LineEdit").text = ""
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer2/LineEdit").text = ""
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer3/OptionButton").selected = -1
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer4/LineEdit").text = ""
    dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer6/TextEdit").text = ""
    dock_item.get_node("HBoxContainer2/VBoxContainer/Panel2/ScrollContainer/Sprite").texture = null
    
func save_item():
    console.info("save item")
    var _name = dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer2/LineEdit").text
    var _type = dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer3/OptionButton").selected
    var _sprite_file = dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer/LineEdit").text
    var _price = dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer4/LineEdit").text
    var _desc = dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer6/TextEdit").text
    db.select("items").insert({"sprite": _sprite_file, "name": _name, "desc": _desc, "type": _type, "price": _price})
    list_item()
    
func del_item():
    var id = dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer7/LineEdit").text
    db.select("items").delete({"id": id})
    list_item()
    
func edit_item():
    pass
    
func show_image_item():
    var path = dock_item.get_node("HBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer/LineEdit").text
    var texture = load(path)
    dock_item.get_node("HBoxContainer2/VBoxContainer/Panel2/ScrollContainer/Sprite").texture = texture
    
func region_change():
    pass

func generate_dropdown_item_type():
    pass
