Class {
	#name : #CTKeyedValuedOrderedCollection,
	#superclass : #Object,
	#instVars : [
		'collection',
		'keyBlock',
		'valueBlock'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #visiting }
CTKeyedValuedOrderedCollection >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCTPostponeOrderedCollection: self
]

{ #category : #accessing }
CTKeyedValuedOrderedCollection >> collection [

	^ collection
]

{ #category : #accessing }
CTKeyedValuedOrderedCollection >> collection: anObject [

	collection := anObject
]

{ #category : #collecting }
CTKeyedValuedOrderedCollection >> keyAndValueOf: anObject [

	^ (keyBlock value: anObject) -> (valueBlock value: anObject)
]

{ #category : #accessing }
CTKeyedValuedOrderedCollection >> keyBlock: anObject [

	keyBlock := anObject
]

{ #category : #accessing }
CTKeyedValuedOrderedCollection >> valueBlock: anObject [

	valueBlock := anObject
]
