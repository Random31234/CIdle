extends Control
#button units
@export var caloriesUnit:ButtonUnitManager
@export var capacityUnit:ButtonUnitManager
#variables
@export var calories:Big
@export var capacity:Big
@export var energy:Big
#buyables
@export var cal:Array[baseUnit]
@export var cap:Array[baseUnit]
@export var ene:baseUnit
#turn tracker
@export var turns:Big
@export var turnEnergyCost:Big

#system for display purposes

var buyamount:int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	caloriesUnit.setUnit(cal)
	capacityUnit.setUnit(cap)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


#this handles buying calories items, consumes capacity
func _on_calories_value(i: int) -> void:
	pass
	


#this handles buying capacity items, consumes energy

func _on_capacity_value(i: int) -> void:
	print(i)
	print("ca")


func endTurn() -> void:
	energy = energy.subtract(energy,turnEnergyCost)
	
	turns.add(turns,1)
