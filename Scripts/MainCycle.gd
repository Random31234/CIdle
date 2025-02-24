extends Control

@export var calories:ButtonUnitManager
@export var capacity:ButtonUnitManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


#this handles buying calories items
func _on_calories_value(i: int) -> void:
	print(i)
	


#this handles buying capacity items.

func _on_capacity_value(i: int) -> void:
	print(i)
	print("ca")
