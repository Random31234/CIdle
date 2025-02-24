extends BoxContainer

signal Value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for x in get_children():
		
		x.get_child(0).connect("button_down",valuePass.bind(x.get_index()))

func valuePass(i:int):
	print(i)
	print("pressed")
