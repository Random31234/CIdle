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
	var c:Big
	c = c.modulo(level,amo)
	if(c.isGreaterThan(0)):
		buy(export,c)
		return
	buy(export,amo)

func buy(export:Big,amo:Big):
	#0<= refers to buy max
	
	var base = cost
	var csm = costScaleMult
	var b:Big
	#first half of equation
	if (amo.isLessThanOrEqualTo(0)):
		pass
	#tests need to be done to get calculations set up.
	b =b.divide(base.multiply(base, csm.subtract(csm.power(csm, amo.add(amo,1)), 1)), csm.subtract(csm,1))
