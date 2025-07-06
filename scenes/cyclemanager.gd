extends Node


@export var cal:Array[baseUnit]
@export var cap:Array[baseUnit]


func _process(delta: float) -> void:
	print(cal[0].level.toScientific())
