"
I use the given instance variable name to provide a value for the argument.
"
Class {
	#name : 'CTInstVarSlotDescriptor',
	#superclass : 'CTBaseSlotDescriptor',
	#category : 'Containers-Essentials-Outliner-Slots',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Slots'
}

{ #category : 'accessing' }
CTInstVarSlotDescriptor >> valueOn: anObject walker: aDfsWalker [

	^ anObject instVarNamed: self selector
]
