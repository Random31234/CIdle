extends Control
class_name tree
# Components to keep in mind for the skill tree.

@export var starter1:skillButton
@export var starter2:skillButton
@export var starter3:skillButton
@export var starter4:skillButton


#the solution accordingly, is to get the children, and get the levels accordingly.




func _ready() -> void:
	print (starter1.get_child(2).addlevel())
