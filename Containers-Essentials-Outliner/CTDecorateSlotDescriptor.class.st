"
I am a variant that stops the visit and provides an already built shape to be referenced in a slot.
"
Class {
	#name : #CTDecorateSlotDescriptor,
	#superclass : #CTPropertySlotDescriptor,
	#instVars : [
		'descriptor'
	],
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #delegating }
CTDecorateSlotDescriptor >> addHighlightInteractionOnShape: aShape [

	^ descriptor addHighlightInteractionOnShape: aShape
]

{ #category : #delegating }
CTDecorateSlotDescriptor >> addHighlightWithLinesInteractionOnShape: aShape [

	^ descriptor addHighlightWithLinesInteractionOnShape: aShape
]

{ #category : #delegating }
CTDecorateSlotDescriptor >> addPopupInteractionOnShape: aShape [

	^ descriptor addPopupInteractionOnShape: aShape
]

{ #category : #accessing }
CTDecorateSlotDescriptor >> descriptor: anObject [

	descriptor := anObject
]

{ #category : #delegating }
CTDecorateSlotDescriptor >> enabled [

	^ descriptor enabled
]

{ #category : #delegating }
CTDecorateSlotDescriptor >> header: aBlock [

	descriptor header: aBlock
]

{ #category : #accessing }
CTDecorateSlotDescriptor >> header: anObject walker: walker [

	^ descriptor header: anObject walker: walker
]

{ #category : #delegating }
CTDecorateSlotDescriptor >> headerWithAllSuperclasses [

	descriptor headerWithAllSuperclasses
]

{ #category : #delegating }
CTDecorateSlotDescriptor >> headerWithClass [

	descriptor headerWithClass
]

{ #category : #delegating }
CTDecorateSlotDescriptor >> ifHasFollowers: block walker: walker [

	^ descriptor ifHasFollowers: block walker: walker
]

{ #category : #delegating }
CTDecorateSlotDescriptor >> inline: anObject level: anInteger default: aBoolean [

	^ descriptor inline: anObject level: anInteger default: aBoolean
]

{ #category : #delegating }
CTDecorateSlotDescriptor >> isOneToMany: anObject walker: aDfsWalker [

	^ descriptor isOneToMany: anObject walker: aDfsWalker
]

{ #category : #delegating }
CTDecorateSlotDescriptor >> noHeader [

	descriptor noHeader
]

{ #category : #delegating }
CTDecorateSlotDescriptor >> selector [

	^ descriptor selector
]

{ #category : #accessing }
CTDecorateSlotDescriptor >> shape: anObject walker: aDfsWalker [

	^ descriptor shape: anObject walker: aDfsWalker
]

{ #category : #accessing }
CTDecorateSlotDescriptor >> valueOn: anObject walker: aDfsWalker [

	^ descriptor valueOn: anObject walker: aDfsWalker
]

{ #category : #delegating }
CTDecorateSlotDescriptor >> varLabelShapeOf: anObject shapeBuilder: aShapeBuilder [

	^ descriptor varLabelShapeOf: anObject shapeBuilder: aShapeBuilder
]
