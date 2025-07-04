extends Control
class_name cycle
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
	buyAmount = Big.new(1,0)
	setUnits()
	

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
	t = capacity.subtract(capacity,cal[i].buy(buyAmount))
	print(t.toScientific())
	print(t.isLessThan(0))
	if(t.mantissa <0):
		return
	
	capacity = t
	
	cal[i].addLevel(buyAmount)
	setUnits()


#this handles buying capacity items, consumes energy
#patch this buygged problem.

func _on_capacity_value(i: int) -> void:
	print(i)
	print("ca")
	var t = energy.subtract(energy,cap[i].buy(buyAmount))
	
	if(t.mantissa <0):
		return
	
	energy = t
	cap[i].addLevel(buyAmount)
	setUnits()


#system to update values accordingly and set buy amounts
func setUnits(i = 1):
	var g = Big.new(1,0)
	
	if (upgradeAmountButton.selected >=1 && upgradeAmountButton.selected < 3):
		g = g.multiply(5,upgradeAmountButton.selected)
	if(upgradeAmountButton.selected == 3 || upgradeAmountButton.selected == 4):
		g = g.multiply(25, g.subtract(upgradeAmountButton.selected,2))
	if(upgradeAmountButton.selected >= 5):
		g = g.power(Big.new(10),upgradeAmountButton.selected -3)
	buyAmount = g
	print("Amount set as buyable")
	caloriesUnit.setUnit(cal,buyAmount)
	capacityUnit.setUnit(cap,buyAmount)
	#put in an update for capt/calt text
	
	#put in update for energy values.
	updateEnergy()

func updateEnergy():
	energyText.text = "Energy amount: " + energy.toScientific() +'\n' + "Calories cost: " + ene.buy(buyAmount).toScientific() + '\n' + "buy amount: " + buyAmount.toScientific()

#next to work on is energy buying.
func buyEnergy():
	
	
	pass

func endTurn() -> void:
	var i = Big.new(0,0)
	#calculation that is done at the end of turn to determine how the upgrades apply all together.
	for x in cal:
		var h = Big.new(1,0)
		var m = Big.new(1,0)
		h = h.multiply(x.level,x.effect)
		i = i.add(i,h)
	#then do multiplications and add accordingly.
	calories = calories.add(calories,i)
	for x in cap:
		var h = Big.new(1,0)
		var m = Big.new(1,0)
		h = h.multiply(x.level,x.effect)
		i = i.add(i,h)
	capacity = calories.add(capacity,i)
	turns.add(turns,1)
	energy = energy.subtract(energy,turnEnergyCost)

func resetCyle():
	pass

func addFactors():
	pass
