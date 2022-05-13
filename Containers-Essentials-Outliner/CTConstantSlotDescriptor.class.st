"
I use the given constant to provide a value for the argument.
"
Class {
	#name : #CTConstantSlotDescriptor,
	#superclass : #CTBaseSlotDescriptor,
	#instVars : [
		'constant'
	],
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #accessing }
CTConstantSlotDescriptor >> constant: anObject [

	constant := anObject
]

{ #category : #accessing }
CTConstantSlotDescriptor >> valueOn: anObject walker: aDfsWalker [

	^ constant
]
