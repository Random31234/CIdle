extends Control
#button units
@export var caloriesUnit:ButtonUnitManager
@export var capacityUnit:ButtonUnitManager
#variables
@export var calories:Big
@export var capacity:Big
@export var energy:Big

#functions var

@export var buyAmount:Big

#UI

@export var upgradeAmountButton:OptionButton

#buyables
@export var cal:Array[baseUnit]
@export var cap:Array[baseUnit]
@export var ene:baseUnit
#turn tracker
@export var turns:Big
@export var turnEnergyCost:Big

#displays

@export var calText:RichTextLabel
@export var calPTText:RichTextLabel
@export var capText:RichTextLabel
@export var capPTText:RichTextLabel
@export var energyText:RichTextLabel
#system for display purposes



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	caloriesUnit.setUnit(cal)
	capacityUnit.setUnit(cap)
	buyAmount = Big.new(1,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	calText.text ="calories: "+ calories.toScientific()
	capText.text ="capacity " + capacity.toScientific()
	


#this handles buying calories items, consumes capacity
func _on_calories_value(i: int) -> void:
	print(i)
	print("cl")
	#need to make condition for buying upgrade
	var t = capacity
	
	print("t val: " + t.toScientific())
	t = capacity.subtract(capacity,cal[i].buy(Big.new(2)))
	print(t.toScientific())
	if (t.isLessThan(0)):
		return
	
	capacity = t
	
	cal[i].addLevel(Big.new(2))
	caloriesUnit.setUnit(cal)
	capacityUnit.setUnit(cap)
	


#this handles buying capacity items, consumes energy

func _on_capacity_value(i: int) -> void:
	print(i)
	print("ca")
	var t = energy.subtract(energy,cap[i].buy(Big.new(1)))
	
	if (t.isLessThan(0)):
		return
	
	energy = t
	caloriesUnit.setUnit(cal)
	capacityUnit.setUnit(cap)


#system to update values accordingly and set buy amounts
func setUnits():
	var g = Big.new(1,0)
	
	if (upgradeAmountButton.selected >=1 && upgradeAmountButton.selected < 3):
		g = g.multiply(5,upgradeAmountButton.selected)
	if(upgradeAmountButton.selected == 3 || upgradeAmountButton.selected == 4):
		g = g.multiply(25, g.subtract(upgradeAmountButton.selected,2))
	if(upgradeAmountButton.selected >= 5):
		g = g.power(Big.new(10),upgradeAmountButton.selected -3)
	caloriesUnit.setUnit(cal)
	capacityUnit.setUnit(cap)
	


func endTurn() -> void:
	
	turns.add(turns,1)
