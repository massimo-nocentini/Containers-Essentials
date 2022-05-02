Class {
	#name : #CTInstVarSlotDescriptor,
	#superclass : #CTBaseSlotDescriptor,
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTInstVarSlotDescriptor >> on: anObject [

	^ anObject instVarNamed: self selector
]
