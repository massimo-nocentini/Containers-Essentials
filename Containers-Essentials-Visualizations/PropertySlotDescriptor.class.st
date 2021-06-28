Class {
	#name : #PropertySlotDescriptor,
	#superclass : #Object,
	#instVars : [
		'selector',
		'value'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #accessing }
PropertySlotDescriptor >> @ aBlock [

	^ BlockSlotDescriptor new
		  selector: selector;
		  blockClosure: aBlock;
		  yourself
]

{ #category : #accessing }
PropertySlotDescriptor >> quote [

	^ QuoteSlotDescriptor new
		  selector: selector;
		  descriptor: self;
		  yourself
]

{ #category : #accessing }
PropertySlotDescriptor >> selector [

	^ selector
]

{ #category : #accessing }
PropertySlotDescriptor >> selector: anObject [

	selector := anObject
]

{ #category : #accessing }
PropertySlotDescriptor >> value: anObject [

	self subclassResponsibility
]
