Class {
	#name : #Edge,
	#superclass : #Object,
	#instVars : [
		'#weight',
		'#from => ToOneRelationSlot inverse: #children inClass: #Vertex',
		'#to => ToOneRelationSlot inverse: #parents inClass: #Vertex'
	],
	#category : #'Collections-Unordered-Graph'
}

{ #category : #accessing }
Edge >> from [
	^ from
]

{ #category : #accessing }
Edge >> from: anObject [
	from := anObject
]

{ #category : #accessing }
Edge >> to [
	^ to
]

{ #category : #accessing }
Edge >> to: anObject [
	to := anObject
]

{ #category : #accessing }
Edge >> weight [
	^ weight isBlock
		ifTrue: [ weight cull: self from content cull: self to content ]
		ifFalse: [ weight ]
]

{ #category : #accessing }
Edge >> weight: anObject [
	weight := anObject
]
