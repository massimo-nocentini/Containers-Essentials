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

	^ aCollectionOfPostpones collection collect: [ :each |
		  | assoc |
		  assoc := aCollectionOfPostpones keyAndValueOf: each.
		  (self newSlotDescriptorString: assoc key constant: assoc value)
			  postpone: true ]
]
