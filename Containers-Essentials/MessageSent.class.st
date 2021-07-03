Class {
	#name : #MessageSent,
	#superclass : #MessageSend,
	#instVars : [
		'return'
	],
	#category : #'Containers-Essentials'
}

{ #category : #comparing }
MessageSent >> = anObject [

	^ super = anObject and: [ return == anObject return ]
]

{ #category : #comparing }
MessageSent >> hash [

	^ super hash bitXor: return hash
]

{ #category : #accessing }
MessageSent >> return [

	^ return
]

{ #category : #accessing }
MessageSent >> return: anObject [

	^ return := anObject
]

{ #category : #accessing }
MessageSent >> value [

	^ return := super value
]

{ #category : #accessing }
MessageSent >> value: anObject [

	^ return := super value: anObject
]

{ #category : #evaluating }
MessageSent >> value: anObject1 value: anObject2 [

	^ return := super value: anObject1 value: anObject2
]

{ #category : #evaluating }
MessageSent >> value: anObject1 value: anObject2 value: anObject3 [

	^ return := super value: anObject1 value: anObject2 value: anObject3
]

{ #category : #evaluating }
MessageSent >> valueWithArguments: anArray [

	^ return := super valueWithArguments: anArray
]

{ #category : #evaluating }
MessageSent >> valueWithEnoughArguments: anArray [

	^ return := super valueWithEnoughArguments: anArray
]
