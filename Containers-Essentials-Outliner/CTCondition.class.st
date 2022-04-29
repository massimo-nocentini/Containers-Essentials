Class {
	#name : #CTCondition,
	#superclass : #Object,
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #API }
CTCondition >> boolean: bool [

	^ self boolean: bool truthWitness: nil
]

{ #category : #API }
CTCondition >> boolean: bool truthWitness: anObject [

	^ bool conditionHandler: self truthWitness: anObject
]

{ #category : #accessing }
CTCondition >> cull: anObject [

	^ self truthWitness: anObject
]

{ #category : #accessing }
CTCondition >> falsehood [

	self subclassResponsibility
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
