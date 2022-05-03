Class {
	#name : #CTCondition,
	#superclass : #Object,
	#category : #'Containers-Essentials-Conditions'
}

{ #category : #accessing }
CTCondition >> cull: anObject [

	^ self truthWitness: anObject
]

{ #category : #accessing }
CTCondition >> falsehood [

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
CTCondition >> ifEmptyIfNotEmpty: collection [

	^ collection ifEmpty: self ifNotEmpty: self
]

{ #category : #API }
CTCondition >> ifTrueIfFalse: bool [

	^ self ifTrueIfFalse: bool truthWitness: nil
]

{ #category : #API }
CTCondition >> ifTrueIfFalse: bool truthWitness: anObject [

	^ bool
		  ifTrue: [ self cull: anObject ]
		  ifFalse: self
]

{ #category : #API }
CTCondition >> lookupInDictionary: dict at: key [

	^ dict at: key ifPresent: self ifAbsent: self
]

{ #category : #accessing }
CTCondition >> truthWitness: anObject [

	self subclassResponsibility
]

{ #category : #accessing }
CTCondition >> value [

	^ self falsehood
]
