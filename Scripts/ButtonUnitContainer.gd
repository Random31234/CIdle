extends BoxContainer
class_name ButtonUnitManager
signal Value(i:int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	
	pass

#need a function to set up the children, and then another function to have them ready


func setUnit():
	
	
	for x in get_children():
		
		x.get_child(0).connect("button_down",valuePass.bind(x.get_index()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func valuePass(i:int):
	print(i)
	print("pressed")
	emit_signal("Value",i)
	return i
