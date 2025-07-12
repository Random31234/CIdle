extends Control
class_name cycle
#button units
@export var caloriesUnit:ButtonUnitManager
@export var capacityUnit:ButtonUnitManager
#manager
@export var cyclem:cyclemanager
#layer1
@export var p:layer1
#variables
@export var calories:Big
@export var capacity:Big
@export var energy:Big

#functions var

@export var buyAmount:Big
@export var calC:int
@export var capC:int

@export var calI:int
@export var capI:int
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


#signals.

signal unlock

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
	#need to make condition for buying upgrade
	var t = capacity
	
	t = capacity.subtract(capacity,cal[i].buy(buyAmount))
	if(t.mantissa <0):
		return
	
	capacity = t
	
	cal[i].addLevel(buyAmount)
	setUnits()


#this handles buying capacity items, consumes energy
#patch this buygged problem.

func _on_capacity_value(i: int) -> void:
	var t = energy.subtract(energy,cap[i].buy(buyAmount))
	
	if(t.mantissa <0):
		return
	
	energy = t
	cap[i].addLevel(buyAmount)
	setUnits()


#system to update values accordingly and set buy amounts
func setUnits():
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
	var e = Big.new(0,0)
	var i = Big.new(1,0)
	var c = Big.new(0,0)
	for x in cal:
		#adding combined effect
		e = e.add(e,i.multiply(x.effect,x.level))
		i = i.multiply(i,individualeffect(x.level,calI))
		c = c.add(c,x.level)
	
	e = e.multiply(i,e)
	e = e.multiply(e,collectiveEffect(c,calC))
	calPTText.text = "Calories Per turn "+ e.toScientific() +'\n'+"I: " + i.toScientific() + '\n' + "C:" + collectiveEffect(c,calC).toScientific()
	e = Big.new(0,0)
	i = Big.new(1,0)
	c = Big.new(0,0)
	for x in cap:
		e = e.add(e,i.multiply(x.effect,x.level))
		i = i.multiply(i,individualeffect(x.level,capI))
		c = c.add(c,x.level)
	capPTText.text = "Capacity Per turn "+ e.toScientific() +'\n'+"I: " + i.toScientific() + '\n' + "C:" + collectiveEffect(c,calC).toScientific()
	
	
	updateEnergy()

func updateEnergy():
	energyText.text = "Energy amount: " + energy.toScientific() +'\n' + "Calories cost: " + ene.buy(buyAmount).toScientific() + '\n' + "buy amount: " + buyAmount.multiply(buyAmount,ene.effect).toScientific()
	

#next to work on is energy buying.
func buyEnergy():
	
	var t = calories.subtract(calories,ene.buy(buyAmount))
	if (t.mantissa <0):
		return
	calories = t
	energy = energy.add(buyAmount.multiply(buyAmount,ene.effect),energy)
	ene.addLevel(buyAmount)
	setUnits()
	print( "cost as in the cycle is!: " + cyclem.cal[0].cost.toScientific())

func endTurn() -> void:
	var i = Big.new(0,0)
	var c = Big.new(0,0)
	var m = Big.new(1,0)
	var ind = Big.new(1,0)
	#calculation that is done at the end of turn to determine how the upgrades apply all together.
	for x in cal:
		var h = Big.new(1,0)
		c = c.add(x.level,c)
		ind = ind.multiply(ind,individualeffect(x.level,calI))
		
		h = h.multiply(x.level,x.effect)
		i = i.add(i,h)
	#then do multiplications and add accordingly.
	c = collectiveEffect(c,calC)
	#first factor is to do individual levels, and then combined levels
	i = i.multiply(i,i.multiply(c,ind))
	
	calories = calories.add(calories,i)
	#reset functions for c, i and m
	c = Big.new(0,0)
	i = Big.new(0,0)
	m = Big.new(1,0)
	ind = Big.new(1,0)
	for x in cap:
		var h = Big.new(1,0)
		c = c.add(x.level,c)
		h = h.multiply(x.level,x.effect)
		i = i.add(i,h)
		ind = ind.multiply(ind,individualeffect(x.level,capI))
	c = collectiveEffect(c,capC)
	i = i.multiply(i,i.multiply(c,ind))
	capacity = calories.add(capacity,i)
	turns.add(turns,1)
	energy = energy.subtract(energy,turnEnergyCost)
	setUnits()
	
	if energy.isLessThan(0):
		resetCyle()
		emit_signal("unlock")

func resetCyle():
	p.fat = p.fat.add(p.fat,calories.divide(calories,2000))
	p.v = p.v.add(p.v,capacity.divide(capacity,10000))
	
	cyclem.reset()
	setUnits()
	calories = Big.new(0,0)
	energy = cyclem.energy
	capacity = cyclem.capacity
	updateEnergy()


func _on_buy_amount_item_selected(index: int) -> void:
	setUnits()


func collectiveEffect(l:Big,s:int):
	var k = Big.new(1,0)
	var m = Big.new(2,0)
	if(s== 0):
		return k
	while s >=1:
		k = k.multiply(k,m.power(m,k.roundDown(l.divide(l,l.multiply(25,l.power(Big.new(2),m.subtract(m,2)))))))
		s-=1
		m =m.add(m,1)
	
	return k
#b refers to amount used to calculate, s refers to scale
func individualeffect(l:Big,s:int):
	var k = Big.new(1,0)
	var m = Big.new(2,0)
	if(s == 0):
		return k
	k = k.multiply(k,k.power(m,k.roundDown(k.divide(l,10))))
	s -=1
	while s >=1:
		m = m.add(m,1)
		k = k.multiply(k,m.power(m,k.roundDown(l.divide(l,l.multiply(25,l.power(Big.new(2),m.subtract(m,3)))))))
		s-=1
	return k
