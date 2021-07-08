Class {
	#name : #QuoRemComplementary,
	#superclass : #Magnitude,
	#instVars : [
		'a',
		'b',
		'quo',
		'rem'
	],
	#category : #'Containers-Essentials'
}

{ #category : #'as yet unclassified' }
QuoRemComplementary class >> a: a b: b [

	^ self basicNew
		  a: a;
		  b: b;
		  initialize;
		  yourself
]

{ #category : #testing }
QuoRemComplementary >> < aMagnitude [

	"Answer whether the receiver is less than the argument."

	^ self asNumber < aMagnitude
]

{ #category : #comparing }
QuoRemComplementary >> = aMagnitude [

	"Compare the receiver with the argument and answer with true if the 
	receiver is equal to the argument. Otherwise answer false."

	^ self asNumber < aMagnitude
]

{ #category : #accessing }
QuoRemComplementary >> a [

	^ a
]

{ #category : #accessing }
QuoRemComplementary >> a: anObject [

	a := anObject
]

{ #category : #converting }
QuoRemComplementary >> asNumber [

	^ a / b
]

{ #category : #accessing }
QuoRemComplementary >> b [

	^ b
]

{ #category : #accessing }
QuoRemComplementary >> b: anObject [

	b := anObject
]

{ #category : #comparing }
QuoRemComplementary >> hash [

	"Hash must be redefined whenever = is redefined."

	^ self asNumber hash
]

{ #category : #accessing }
QuoRemComplementary >> initialize [

	quo := self asNumber ceiling.
	rem := a - (quo * b)
]

{ #category : #accessing }
QuoRemComplementary >> quo [

	^ quo
]

{ #category : #accessing }
QuoRemComplementary >> rem [

	^ rem
]
