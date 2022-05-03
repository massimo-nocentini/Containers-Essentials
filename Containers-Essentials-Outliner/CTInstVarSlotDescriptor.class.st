Class {
	#name : #CTInstVarSlotDescriptor,
	#superclass : #CTBaseSlotDescriptor,
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #accessing }
CTInstVarSlotDescriptor >> on: anObject [

	^ anObject instVarNamed: self selector
]
