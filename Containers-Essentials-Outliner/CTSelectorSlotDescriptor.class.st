Class {
	#name : #CTSelectorSlotDescriptor,
	#superclass : #CTBaseSlotDescriptor,
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTSelectorSlotDescriptor >> valueOn: anObject walker: aDfsWalker [

	^ anObject perform: self selector
]
