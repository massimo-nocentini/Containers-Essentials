"
I am a dummy class to test the postpone feature of slot descriptors.
"
Class {
	#name : #CTDummyForPostpone,
	#superclass : #Object,
	#instVars : [
		'name',
		'cross'
	],
	#category : #'Containers-Essentials-Tests-SUTs'
}

{ #category : #visiting }
CTDummyForPostpone >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCTDummyForPostpone: self
]

{ #category : #converting }
CTDummyForPostpone >> asShapeSlotsDfsTree: dfsWalker [

	dfsWalker slotDescriptorsVisitor:
		CTPostponeSlotDescriptorsVisitor new.

	^ super asShapeSlotsDfsTree: dfsWalker
]

{ #category : #accessing }
CTDummyForPostpone >> cross [

	^ cross
]

{ #category : #accessing }
CTDummyForPostpone >> cross: anObject [

	cross := anObject
]

{ #category : #accessing }
CTDummyForPostpone >> name [

	^ name
]

{ #category : #accessing }
CTDummyForPostpone >> name: anObject [

	name := anObject
]
