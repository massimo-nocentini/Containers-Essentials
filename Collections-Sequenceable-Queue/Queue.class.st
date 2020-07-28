Class {
	#name : #Queue,
	#superclass : #Object,
	#instVars : [
		'front',
		'rear'
	],
	#category : #'Collections-Sequenceable-Queue'
}

{ #category : #testing }
Queue >> add: x [
	^ self class new
		  front: front;
		  rear: x ~~> rear;
		  invariant
]

{ #category : #accessing }
Queue >> front: anObject [
	front := anObject
]

{ #category : #testing }
Queue >> invariant [
	^ front
		  ifNil: [ 
			  self class new
				  front: rear reversed;
				  rear: front;
				  yourself ]
		  ifNotNil: [ self ]
]

{ #category : #testing }
Queue >> isEmpty [
	^ front isNil
]

{ #category : #testing }
Queue >> min [
	^ front
		  ifNil: [ CollectionIsEmpty signal ]
		  ifNotNil: [ :aValueLink | aValueLink value ]
]

{ #category : #testing }
Queue >> pop [
	^ front
		  ifNil: [ CollectionIsEmpty signal ]
		  ifNotNil: [ :aValueLink | 
			  self class new
				  front: aValueLink nextLink;
				  rear: rear;
				  invariant ]
]

{ #category : #accessing }
Queue >> rear: anObject [
	rear := anObject
]
