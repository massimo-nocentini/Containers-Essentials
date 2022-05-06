Class {
	#name : #CTxValueSlotDescriptor,
	#superclass : #CTBaseSlotDescriptor,
	#instVars : [
		'value'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTxValueSlotDescriptor >> value [

	^ value
]

{ #category : #accessing }
CTxValueSlotDescriptor >> value: anObject [

	value := anObject
]

{ #category : #accessing }
CTxValueSlotDescriptor >> valueOn: anObject walker: aDfsWalker [

	^ value
]
