extends BoxContainer
class_name ButtonUnitManager
signal Value(i:int)

@export var type:String
# Load the scene file
var buttonUnit = preload("res://scenes/ButtonUnit.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	pass

#need a function to set up the children, and then another function to have them ready


func setUnit(a:Array[baseUnit]):
	
	#delete all children first
	for child in get_children():
		child.queue_free()
		child.free()
	
	var y = 0
	
	for z in a:
		var inst = buttonUnit.instantiate()
		add_child(inst)
		inst.get_child(0).connect("button_down",valuePass.bind(inst.get_index()))
		print(str(inst.get_index()) + ": value of instantiated index")
		if(inst.get_index() <a.size()):
			inst.get_child(1).texture = a[y].texture
		inst.get_child(2).text = a[y].name + " : " + a[y].level.toScientific() + '\n' + "effect: " + a[y].effect.toScientific() + '\n' + "costs: " + a[y].cost.toScientific() + " " + type
		
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func valuePass(i:int):
	print(i)
	print("pressed")
	emit_signal("Value",i)
	return i
