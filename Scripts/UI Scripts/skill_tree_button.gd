extends TextureButton

class_name skillButton
@onready var panel = $Panel
@onready var label = $MarginContainer/Label
@export var limit:int
@export var cost:Big
@export var scaler:Big






signal c(c:Big, o:Node)
#take this into factor next time for more purposeful uses.

#this is an interesting factor to take into account for next time
var level: int = 0:
	set(value):
		if(value <= limit):
			level = value
		label.text = str(level) + "/" + str(limit)


func _on_button_down() -> void:
	emit_signal("c",cost.multiply(scaler.power(scaler,level),cost),self)

func addlevel():
	level +=1
