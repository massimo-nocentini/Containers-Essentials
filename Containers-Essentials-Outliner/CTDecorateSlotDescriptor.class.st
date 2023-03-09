"
I am a decorator so my duty is to forward messages to the decorated slot descriptor.
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

{ #category : #'as yet unclassified' }
CTDecorateSlotDescriptor >> dispatchPostponed: child data: data walker: walker otherwise: oBlock [

	^ descriptor
		  dispatchPostponed: child
		  data: data
		  walker: walker
		  otherwise: oBlock
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

{ #category : #testing }
CTDecorateSlotDescriptor >> isEnabledAtLevel: l [

	^ descriptor isEnabledAtLevel: l
]

{ #category : #testing }
CTDecorateSlotDescriptor >> isOneToMany [

	^ descriptor isOneToMany
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
CTDecorateSlotDescriptor >> valueOn: anObject walker: aDfsWalker [

	^ descriptor valueOn: anObject walker: aDfsWalker
]

{ #category : #accessing }
CTDecorateSlotDescriptor >> valueShapeOf: anObject walker: aDfsWalker [

	^ descriptor valueShapeOf: anObject walker: aDfsWalker
]

{ #category : #delegating }
CTDecorateSlotDescriptor >> varShapeOf: anObject walker: walker [

	^ descriptor varShapeOf: anObject walker: walker
]
