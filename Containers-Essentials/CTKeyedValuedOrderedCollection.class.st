"
I'm a wrapper over a collection providing the capability to use two blocks for representing my objects as `Association`s.
"
Class {
	#name : 'CTKeyedValuedOrderedCollection',
	#superclass : 'Object',
	#instVars : [
		'collection',
		'keyBlock',
		'valueBlock'
	],
	#category : 'Containers-Essentials-Collections',
	#package : 'Containers-Essentials',
	#tag : 'Collections'
}

{ #category : 'visiting' }
CTKeyedValuedOrderedCollection >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCTKeyedValuedOrderedCollection: self
]

{ #category : 'collecting' }
CTKeyedValuedOrderedCollection >> associationOf: anObject [

	^ (keyBlock value: anObject) -> (valueBlock value: anObject)
]

{ #category : 'accessing' }
CTKeyedValuedOrderedCollection >> collection [

	^ collection
]

{ #category : 'accessing' }
CTKeyedValuedOrderedCollection >> collection: anObject [

	collection := anObject
]

{ #category : 'testing' }
CTKeyedValuedOrderedCollection >> isCollection [

	^ true
]

{ #category : 'testing' }
CTKeyedValuedOrderedCollection >> isEmpty [

	^ collection isEmpty
]

{ #category : 'accessing' }
CTKeyedValuedOrderedCollection >> keyBlock: anObject [

	keyBlock := anObject
]

{ #category : 'enumerating' }
CTKeyedValuedOrderedCollection >> keysAndValuesCollect: aBlock [

	^ collection collect: [ :each |
		  | assoc |
		  assoc := self associationOf: each.
		  aBlock value: assoc key value: assoc value ]
]

{ #category : 'accessing' }
CTKeyedValuedOrderedCollection >> valueBlock: anObject [

	valueBlock := anObject
]
