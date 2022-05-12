Class {
	#name : #CTxValueSlotDescriptor,
	#superclass : #CTBaseSlotDescriptor,
	#instVars : [
		'value'
	],
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #accessing }
CTxValueSlotDescriptor >> value: anObject [

	value := anObject
]

{ #category : #accessing }
CTxValueSlotDescriptor >> valueOn: anObject walker: aDfsWalker [

	^ value
]
