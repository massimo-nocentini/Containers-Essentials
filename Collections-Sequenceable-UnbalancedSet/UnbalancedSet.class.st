Class {
	#name : #UnbalancedSet,
	#superclass : #Object,
	#traits : 'TContainerSet',
	#classTraits : 'TContainerSet classTrait',
	#instVars : [
		'representation'
	],
	#category : #'Collections-Sequenceable-UnbalancedSet'
}

{ #category : #requirements }
UnbalancedSet class >> empty [
	^ self new
		  representation: nil;
		  yourself
]

{ #category : #adding }
UnbalancedSet >> inDoubleLinkRepresentation: aDoubleLink includes: anObject witness: aWitness [

	| aRefinedWitness leftLink rightLink |
	aRefinedWitness := aDoubleLink value.
	leftLink := aDoubleLink previousLink.
	rightLink := aDoubleLink nextLink.
	^ anObject < aRefinedWitness
		  ifTrue: [ 
		  leftLink
			  includes: anObject
			  witness: aWitness
			  inUnbalancedSet: self ]
		  ifFalse: [ 
			  rightLink
				  includes: anObject
				  witness: aRefinedWitness
				  inUnbalancedSet: self ]
]

{ #category : #adding }
UnbalancedSet >> inDoubleLinkRepresentation: aDoubleLink push: anObject witness: aWitness continuation: aContinuation [
	| aRefinedWitness leftLink rightLink newLink |
	aRefinedWitness := aDoubleLink value.
	leftLink := aDoubleLink previousLink.
	rightLink := aDoubleLink nextLink.
	^ anObject < aRefinedWitness
		  ifTrue: [ 
			  newLink := leftLink
				             push: anObject
				             witness: aWitness
				             continuation: aContinuation
				             inUnbalancedSet: self.
			  DoubleLink new
				  previousLink: newLink;
				  value: aRefinedWitness;
				  nextLink: representation nextLink;
				  yourself ]
		  ifFalse: [ 
			  newLink := rightLink
				             push: anObject
				             witness: aRefinedWitness
				             continuation: aContinuation
				             inUnbalancedSet: self.
			  DoubleLink new
				  previousLink: leftLink;
				  value: aRefinedWitness;
				  nextLink: newLink;
				  yourself ]
]

{ #category : #adding }
UnbalancedSet >> inNilRepresentation: _ includes: anObject witness: aWitness [

	^ anObject = aWitness
]

{ #category : #adding }
UnbalancedSet >> inNilRepresentation: _ push: anObject witness: aWitness continuation: aContinuation [
	^ anObject = aWitness
		  ifTrue: [ aContinuation value: representation ]
		  ifFalse: [ 
			  DoubleLink new
				  value: anObject;
				  yourself ]
]

{ #category : #adding }
UnbalancedSet >> includes: anObject [

	^ representation
		  includes: anObject
		  witness: nil
		  inUnbalancedSet: self
]

{ #category : #adding }
UnbalancedSet >> push: anObject [
	| repr |
	repr := [ :hop | 
	        (representation
		         push: anObject
		         witness: nil
		         continuation: hop
		         inUnbalancedSet: self) yourself ]
		        callWithCurrentContinuation.
	^ self class new
		  representation: repr;
		  yourself
]

{ #category : #accessing }
UnbalancedSet >> representation [
	^ representation
]

{ #category : #accessing }
UnbalancedSet >> representation: anObject [
	representation := anObject
]
