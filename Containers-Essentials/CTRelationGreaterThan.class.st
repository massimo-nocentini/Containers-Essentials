Class {
	#name : 'CTRelationGreaterThan',
	#superclass : 'CTRelation',
	#category : 'Containers-Essentials-Messaging',
	#package : 'Containers-Essentials',
	#tag : 'Messaging'
}

{ #category : 'as yet unclassified' }
CTRelationGreaterThan >> slowExplicitFibonacci: anInteger tail: anotherInteger greaterThanZero: aReceiver [

	^ aReceiver
		  slowExplicitFibonacci: anInteger
		  tail: anotherInteger
		  greaterThanZeroIsTrue: self
]
