Class {
	#name : #PropertySlotDescriptor,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #accessing }
PropertySlotDescriptor >> doesDescribeAnImmediateObject [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> quote [

	^ QuoteSlotDescriptor new
		  descriptor: self;
		  yourself
]

{ #category : #accessing }
PropertySlotDescriptor >> selector [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> value: anObject [

	self subclassResponsibility
]
