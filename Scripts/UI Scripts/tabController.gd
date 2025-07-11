extends TabContainer

@export var r:layer1
@export var c:cycle


@export var ractive:bool
func _ready() -> void:
	self.set_tab_hidden(2,true)


func unlocker():
	self.set_tab_hidden(2,!ractive)
	

func restUnlocker():
	ractive = true
	unlocker()
