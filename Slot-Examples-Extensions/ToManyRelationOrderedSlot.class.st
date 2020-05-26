"
I'm a relation slot  that  describes  slots that contain collections, that should be kept ordered.
"
Class {
	#name : #ToManyRelationOrderedSlot,
	#superclass : #ToManyRelationSlot,
	#category : #'Slot-Examples-Extensions'
}

{ #category : #initialization }
ToManyRelationOrderedSlot >> initialize: anObject [
	self
		write: (RelationSequentiableCollection owner: anObject slot: self)
		to: anObject
]
