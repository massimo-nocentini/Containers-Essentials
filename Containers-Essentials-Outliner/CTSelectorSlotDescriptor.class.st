"
I use the given selector to provide a value for the argument.
"
Class {
	#name : 'CTSelectorSlotDescriptor',
	#superclass : 'CTBaseSlotDescriptor',
	#category : 'Containers-Essentials-Outliner-Slots',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Slots'
}

{ #category : 'accessing' }
CTSelectorSlotDescriptor >> valueOn: anObject walker: aDfsWalker [

	^ anObject perform: self selector
]
