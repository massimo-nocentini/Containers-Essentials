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
