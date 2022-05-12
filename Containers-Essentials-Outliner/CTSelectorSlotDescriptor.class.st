Class {
	#name : #CTSelectorSlotDescriptor,
	#superclass : #CTBaseSlotDescriptor,
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #accessing }
CTSelectorSlotDescriptor >> valueOn: anObject walker: aDfsWalker [

	^ anObject perform: self selector
]
