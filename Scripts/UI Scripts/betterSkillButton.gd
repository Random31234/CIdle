extends Button

class_name BetterSkillButton

@onready var panel = $Panel
@onready var label = $MarginContainer/Label
@export var limit:int
@export var cost:Big
@export var scaler:Big


func _ready() -> void:
	addLevel()

@export var level: int = 0:
	set(value):
		if(value <= limit):
			level = value
		label.text = str(level) + "/" + str(limit)
	
	


func addLevel():
	level +=1
	
