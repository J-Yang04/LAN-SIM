@abstract class_name ActiveEffect

## Everything in the game that has a special effect gets an ActiveEffect.
## These ActiveEffects describe the trigger for the special effect,
## and contain a function that runs when the trigger is met.
## During runtime, all the ActiveEffects of an object are collected together
## and queried each time a trigger is met.
## ActiveEffects can activate when their condition is met, or when a related action is taken.
## Hopefully, this is extensible and flexible.
## Tags are also ActiveEffects.

var name:String
var effects:Array
## The trigger for this active effect
var trigger:Enums.Event
## The duration for this active effect, counted in the number of times it can trigger before it expires. 
## If this is -1, it lasts indefinitely.
var duration:int

## THIS SHOULD BE ABSTRACT, AND NEEDS WORK
func trigger_active_effect() -> String:
	return "THIS ACTIVE EFFECT DOES NOTHING RIGHT NOW"
