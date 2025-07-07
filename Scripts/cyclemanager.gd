extends Node

class_name cyclemanager


@export var cal:Array[baseUnit]
@export var cap:Array[baseUnit]
@export var energy:Big
@export var capacity:Big


func reset():
	for x in cal:
		x.resetToOG()
	for x in cap:
		x.resetToOG()


func factor():
	pass
