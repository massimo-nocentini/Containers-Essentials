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
CTPostponeSlotDescriptorsVisitor >> visitCTPostponeOrderedCollection: aCollectionOfPostpones [

	^ aCollectionOfPostpones collect: [ :each |
		  (self newSlotDescriptorString: each name constant: each cross)
			  postpone: true ]
]
