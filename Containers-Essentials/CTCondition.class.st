Class {
	#name : #CTCondition,
	#superclass : #Object,
	#instVars : [
		'requestor',
		'data'
	],
	#category : #'Containers-Essentials-Conditions'
}

{ #category : #'instance creation' }
CTCondition class >> requestor: requestor data: data [

	^ self basicNew
		  requestor: requestor;
		  data: data;
		  initialize;
		  yourself
]

{ #category : #accessing }
CTCondition >> cull: anObject [

	^ self truthWitness: anObject
]

{ #category : #accessing }
CTCondition >> data: anObject [

	data := anObject
]

{ #category : #accessing }
CTCondition >> falsehood [

	self subclassResponsibility
]

{ #category : #API }
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
CTCondition >> requestor: anObject [

	requestor := anObject
]

{ #category : #accessing }
CTCondition >> truthWitness: anObject [

	self subclassResponsibility
]

{ #category : #accessing }
CTCondition >> value [

	^ self falsehood
]
