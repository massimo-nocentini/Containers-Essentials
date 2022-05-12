Class {
	#name : #CTInstVarSlotDescriptor,
	#superclass : #CTBaseSlotDescriptor,
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #accessing }
CTInstVarSlotDescriptor >> valueOn: anObject walker: aDfsWalker [

	^ anObject instVarNamed: self selector
]
