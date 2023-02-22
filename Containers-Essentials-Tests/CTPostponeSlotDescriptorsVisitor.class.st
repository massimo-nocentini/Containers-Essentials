Class {
	#name : #CTPostponeSlotDescriptorsVisitor,
	#superclass : #CTSlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Tests'
}

{ #category : #visiting }
CTPostponeSlotDescriptorsVisitor >> visitCTDummyForPostpone: anObject [

	^ {
		  (self newSlotDescriptorSelector: #name).
		  ((self newSlotDescriptorSelector: #cross) postpone: true) }
]

{ #category : #visiting }
CTPostponeSlotDescriptorsVisitor >> visitCTKeyedValuedOrderedCollection: aCollectionOfPostpones [

	^ (super visitCTKeyedValuedOrderedCollection: aCollectionOfPostpones)
		  collect: [ :each | each postpone: true ]
]
