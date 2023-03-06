Class {
	#name : #CTDummyForOneToMany,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'Containers-Essentials-Tests'
}

{ #category : #visiting }
CTDummyForOneToMany >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCTDummyForOneToMany: self
]

{ #category : #accessing }
CTDummyForOneToMany >> collection [

	^ collection
]

{ #category : #accessing }
CTDummyForOneToMany >> collection: anObject [

	collection := anObject
]
