Class {
	#name : #Vertex,
	#superclass : #Object,
	#instVars : [
		'#content',
		'#children => ToManyRelationOrderedSlot inverse: #from inClass: #Edge',
		'#parents => ToManyRelationOrderedSlot inverse: #to inClass: #Edge'
	],
	#category : #'Collections-Unordered-Graph'
}

{ #category : #comparing }
Vertex >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ content = anObject content
]

{ #category : #accessing }
Vertex >> children [
	^ children
]

{ #category : #accessing }
Vertex >> children: anObject [
	children := anObject
]

{ #category : #accessing }
Vertex >> content [
	^ content
]

{ #category : #accessing }
Vertex >> content: anObject [
	content := anObject
]

{ #category : #comparing }
Vertex >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ content hash
]

{ #category : #accessing }
Vertex >> initialize [
	self class initializeSlots: self.
	super initialize
]

{ #category : #accessing }
Vertex >> parents [
	^ parents
]

{ #category : #accessing }
Vertex >> parents: anObject [
	parents := anObject
]
