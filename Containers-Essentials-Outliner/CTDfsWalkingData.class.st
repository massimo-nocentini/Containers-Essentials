"
I am a data holder for the DFS visit recursive steps.
"
Class {
	#name : #CTDfsWalkingData,
	#superclass : #Object,
	#instVars : [
		'descriptor',
		'level',
		'parent',
		'labelsWidth',
		'boxesWidth',
		'rowsInlined',
		'rowsOutgoing',
		'object',
		'shape',
		'hasOutgoings',
		'exploringDescriptors'
	],
	#category : #'Containers-Essentials-Outliner-Walkers'
}

{ #category : #adding }
CTDfsWalkingData >> addRowGroup: aGroup inlined: aBoolean [

	| dict |
	dict := aBoolean
		        ifTrue: [ rowsInlined ]
		        ifFalse: [ rowsOutgoing ].

	^ dict at: rowsInlined size + rowsOutgoing size + 1 put: aGroup
]

{ #category : #accessing }
CTDfsWalkingData >> boxesWidth [

	^ boxesWidth
]

{ #category : #accessing }
CTDfsWalkingData >> boxesWidth: anObject [

	boxesWidth := anObject
]

{ #category : #accessing }
CTDfsWalkingData >> descriptor [

	^ descriptor
]

{ #category : #accessing }
CTDfsWalkingData >> descriptor: anObject [

	descriptor := anObject
]

{ #category : #accessing }
CTDfsWalkingData >> exploringDescriptors [

	^ exploringDescriptors
]

{ #category : #accessing }
CTDfsWalkingData >> exploringDescriptors: anObject [

	exploringDescriptors := anObject
]

{ #category : #accessing }
CTDfsWalkingData >> hasOutgoings [

	^ hasOutgoings
]

{ #category : #accessing }
CTDfsWalkingData >> hasOutgoings: anObject [

	hasOutgoings := anObject
]

{ #category : #initialization }
CTDfsWalkingData >> initialize [

	super initialize.

	rowsInlined := SmallDictionary new.
	rowsOutgoing := SmallDictionary new
]

{ #category : #accessing }
CTDfsWalkingData >> labelsWidth [

	^ labelsWidth
]

{ #category : #accessing }
CTDfsWalkingData >> labelsWidth: anObject [

	labelsWidth := anObject
]

{ #category : #accessing }
CTDfsWalkingData >> level [

	^ level
]

{ #category : #accessing }
CTDfsWalkingData >> level: anObject [

	level := anObject
]

{ #category : #accessing }
CTDfsWalkingData >> object [

	^ object
]

{ #category : #accessing }
CTDfsWalkingData >> object: anObject [

	object := anObject
]

{ #category : #accessing }
CTDfsWalkingData >> parent [

	^ parent
]

{ #category : #accessing }
CTDfsWalkingData >> parent: anObject [

	parent := anObject
]

{ #category : #accessing }
CTDfsWalkingData >> rows [

	| array |
	array := Array new: rowsInlined size + rowsOutgoing size.

	rowsInlined keysAndValuesDo: [ :i :group | array at: i put: group ].
	rowsOutgoing keysAndValuesDo: [ :i :group | array at: i put: group ].

	^ array
]

{ #category : #accessing }
CTDfsWalkingData >> shape [

	^ shape
]

{ #category : #accessing }
CTDfsWalkingData >> shape: anObject [

	shape := anObject
]
