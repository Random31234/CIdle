extends Resource

class_name baseUnit
#original values
@export var ogPrice:Big
@export var ogEffect:Big
@export var ogCostScaleMult:Big
@export var ogCostScaleAdd:Big


#cost and effect base
@export var price:Big
@export var effect:Big
#scalers
@export var costScaleMult:Big
@export var costScaleAdd:Big
#current cost and level
@export var cost:Big
@export var level:Big
#cosmetics
@export var name:String
@export var texture:Texture2D


#Make a buy amount that works accordingly.

#BuyUpto is a means to set up how many is bought to a nice round number with modulo

func buyUpto(export:Big,amo:Big):
	
	#declare a value accordingly when time comes.
	var c:Big
	c = c.modulo(level,amo)
	if(c.isGreaterThan(0)):
		return buy(c)
		
	return buy(amo)
	

func buy(amo:Big):
	#0<= refers to buy max
	
	#set up a value accordingly and make sure mathematics are correct.
	#base refers go current cost
	var base = cost
	var csm = costScaleMult
	var csa = costScaleAdd
	var b:Big
	#b = base
	b = Big.new(1,0)
	var a:Big
	#a = adder
	a = Big.new(0,0)
	var bought:Big
	bought = Big.new(0,0)
	#first half of equation
	if (amo.isLessThanOrEqualTo(0)):
		bought = Big.new(0)
		print("Nothing is bought")
		return bought
		
	if(amo.isEqualTo(1)):
		print("One is bought")
		return base
	
	#conditions should be put into place for multipliers that are at 1
	
	
	
	#tests need to be done to get calculations set up.
	
	#if the multiply scaler is 1
	if(csm.isEqualTo(1)):
		b = b.multiply(base,amo)
		if(csa.isGreaterThan(0)):
			a = a.multiply(csa,amo.divide(amo.multiply(amo.subtract(amo,1),amo),2))
		
		b  = b.add(a,b)
		print(b.toScientific() + " Output of upgrade")
		return b
	amo =amo.subtract(amo,1)
	#otherwise if the multiply scaler is above or less than 1
	b = b.divide(b.multiply(base,b.subtract(b.power(csm,b.add(amo,1)),1)),b.subtract(csm,1))
	if(csa.isGreaterThan(0)):
		#this part has a flaw.
		var h = Big.new(1,0)
		h = h.divide(csm.subtract(csm.power(csm,csm.add(amo,2)),csm.power(csm,2)),csm.power(csm.subtract(csm, 1),2))
		var d = Big.new(1,0)
		d = d.divide(csm.multiply(csm,amo),csm.subtract(csm,1))
		a = a.subtract(h,d)
		a = a.multiply(csa, a)
	b = b.add(a,b)
	
	
	print(b.toScientific() + " Output of upgrade")
	return b


func addLevel(ad:Big):
	level =level.add(ad,level)
	var h = Big.new(1,0)
	h= cost.multiply(price,costScaleMult.power(costScaleMult,level))
	var a = Big.new(1,0)
	a = cost.multiply(costScaleAdd,a)
	var d = Big.new(1,0)
	d = costScaleMult.multiply(costScaleMult,costScaleMult.divide(costScaleMult.subtract(1,costScaleMult.power(costScaleMult,level)),costScaleMult.subtract(1,costScaleMult)))
	a = a.multiply(a,d)
	if(costScaleMult.isEqualTo(1)):
		a = costScaleAdd.multiply(costScaleAdd,level)
	cost = h.add(h,a)
	print(d.toScientific() + " = = = =  d")
	print(h.toScientific() + " = = = =  h ")
	print(cost.toScientific())

func resetLevels():
	level = Big.new(0,0)
	addLevel(Big.new(0,0))
	

func resetToOG():
	costScaleAdd = ogCostScaleAdd
	costScaleMult = ogCostScaleMult
	effect = ogEffect
	price = ogPrice

func fullReset():
	resetToOG()
	resetLevels()
