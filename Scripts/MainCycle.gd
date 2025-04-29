extends Control
#button units
@export var caloriesUnit:ButtonUnitManager
@export var capacityUnit:ButtonUnitManager
#variables
@export var calories:Big
@export var capacity:Big
@export var energy:Big

#the shop items

#prices of the items
@export var calPrices:Array[Big]
@export var capPrices:Array[Big]
@export var energyPrice:Big
#levels of item in the shop
@export var calLevels:Array[Big]
@export var capLevels:Array[Big]
#effects of items in the shop
@export var calEffect:Array[Big]
@export var capEffect:Array[Big]
#scaling of items in the shop.
@export var calCostScaling:Array[Big]
@export var capCostScaling:Array[Big]
#turn tracker
@export var turns:Big

#system for display purposes
@export var calSprites:Array[Sprite2D]
@export var capSprites:Array[Sprite2D]
@export var calNames:Array[String]
@export var capNames:Array[String]

var buyamount:int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	caloriesUnit.setUnit()
	capacityUnit.setUnit()


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
