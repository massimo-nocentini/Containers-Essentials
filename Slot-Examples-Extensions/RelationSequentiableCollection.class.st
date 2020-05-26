Class {
	#name : #RelationSequentiableCollection,
	#superclass : #Collection,
	#instVars : [
		'owner',
		'slot',
		'collection'
	],
	#category : #'Slot-Examples-Extensions'
}

{ #category : #creating }
RelationSequentiableCollection class >> owner: anObject slot: aToManyAssociation [
	^ self new initializeOwner: anObject slot: aToManyAssociation
]

{ #category : #adding }
RelationSequentiableCollection >> add: anObject [
	slot add: anObject to: owner.
	^ collection add: anObject
]

{ #category : #copying }
RelationSequentiableCollection >> copy [
	^ self species new
		addAll: self;
		yourself
]

{ #category : #enumerating }
RelationSequentiableCollection >> do: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument."

	collection do: aBlock
]

{ #category : #initialization }
RelationSequentiableCollection >> initializeOwner: anObject slot: aToManyAssociation [
	owner := anObject.
	slot := aToManyAssociation.
	collection := self species new
]

{ #category : #adding }
RelationSequentiableCollection >> inverseAdd: anObject [
	^ collection add: anObject
]

{ #category : #removing }
RelationSequentiableCollection >> inverseRemove: anObject [
	^ collection remove: anObject
]

{ #category : #removing }
RelationSequentiableCollection >> remove: oldObject ifAbsent: aBlock [
	(collection includes: oldObject)
		ifFalse: [ ^ aBlock value ].
	slot remove: oldObject from: owner.
	^ collection remove: oldObject ifAbsent: aBlock
]

{ #category : #accessing }
RelationSequentiableCollection >> size [
	^ collection ifNil: [ 0 ] ifNotNil: [ collection size ]
]

{ #category : #private }
RelationSequentiableCollection >> species [
	^ OrderedCollection
]
