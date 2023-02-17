Class {
	#name : #CTPostponeOrderedCollection,
	#superclass : #OrderedCollection,
	#category : #'Containers-Essentials-Tests'
}

{ #category : #visiting }
CTPostponeOrderedCollection >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCTPostponeOrderedCollection: self
]
