extends Resource

class_name baseUnit
#cost
@export var price:Big
@export var level:Big
@export var effect:Big
#scalers
@export var costScaleMult:Big
@export var costScaleAdd:Big
#current cost/base cost
@export var cost:Big
@export var name:String
@export var texture:Texture2D


#Make a buy amount that works accordingly.

#BuyUpto is a means to set up how many is bought to a nice round number with modulo

func buyUpto(export:Big,amo:Big):
	
	#declare a value accordingly when time comes.
	var c:Big
	c = c.modulo(level,amo)
	if(c.isGreaterThan(0)):
		buy(export,c)
		return
	buy(export,amo)
	

func buy(export:Big,amo:Big):
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
		bought = Big.new(-1.0)
		return bought
		
	if(amo.isEqualTo(1)):
		return base
	amo =amo.subtract(amo,1)
	#tests need to be done to get calculations set up.
	b = b.divide(b.multiply(base,b.subtract(b.power(csm,b.add(amo,1)),1)),b.subtract(csm,1))
	if(csa.isGreaterThan(0)):
		a = a.multiply(a.divide(a.multiply(csa,csm),a.power(a.subtract(csm,Big.new(1)),Big.new(2))),a.subtract(a.power(csm,a.add(amo,Big.new(1))),a.subtract(Big.new(1),a.multiply(a.add(amo,Big.new(1)),a.subtract(csm,Big.new(1))))))
	b = b.add(a,b)
	if(b.isLessThanOrEqualTo(export)):
		print(b.toScientific() + " Output of upgrade")
		return b
