"
I am a data holder for the DFS visit recursive steps.
"
Class {
	#name : #CTDfsWalkerData,
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
CTDfsWalkerData >> addRowGroup: aGroup inlined: aBoolean [

	| dict |
	dict := aBoolean
		        ifTrue: [ rowsInlined ]
		        ifFalse: [ rowsOutgoing ].

	^ dict at: rowsInlined size + rowsOutgoing size + 1 put: aGroup
]

{ #category : #accessing }
CTDfsWalkerData >> boxesWidth [

	^ boxesWidth
]

{ #category : #accessing }
CTDfsWalkerData >> boxesWidth: anObject [

	boxesWidth := anObject
]

{ #category : #accessing }
CTDfsWalkerData >> descriptor [

	^ descriptor
]

{ #category : #accessing }
CTDfsWalkerData >> descriptor: anObject [

	descriptor := anObject
]

{ #category : #accessing }
CTDfsWalkerData >> exploringDescriptors [

	^ exploringDescriptors
]

{ #category : #accessing }
CTDfsWalkerData >> exploringDescriptors: anObject [

	exploringDescriptors := anObject
]

{ #category : #accessing }
CTDfsWalkerData >> hasOutgoings [

	^ hasOutgoings
]

{ #category : #accessing }
CTDfsWalkerData >> hasOutgoings: anObject [

	hasOutgoings := anObject
]

{ #category : #initialization }
CTDfsWalkerData >> initialize [

	super initialize.

	rowsInlined := SmallDictionary new.
	rowsOutgoing := SmallDictionary new
]

{ #category : #accessing }
CTDfsWalkerData >> labelsWidth [

	^ labelsWidth
]

{ #category : #accessing }
CTDfsWalkerData >> labelsWidth: anObject [

	labelsWidth := anObject
]

{ #category : #accessing }
CTDfsWalkerData >> level [

	^ level
]

{ #category : #accessing }
CTDfsWalkerData >> level: anObject [

	level := anObject
]

{ #category : #accessing }
CTDfsWalkerData >> object [

	^ object
]

{ #category : #accessing }
CTDfsWalkerData >> object: anObject [

	object := anObject
]

{ #category : #accessing }
CTDfsWalkerData >> parent [

	^ parent
]

{ #category : #accessing }
CTDfsWalkerData >> parent: anObject [

	parent := anObject
]

{ #category : #accessing }
CTDfsWalkerData >> rows [

	| array |
	array := Array new: rowsInlined size + rowsOutgoing size.

	rowsInlined keysAndValuesDo: [ :i :group | array at: i put: group ].
	rowsOutgoing keysAndValuesDo: [ :i :group | array at: i put: group ].

	^ array
]

{ #category : #accessing }
CTDfsWalkerData >> shape [

	^ shape
]

{ #category : #accessing }
CTDfsWalkerData >> shape: anObject [

	shape := anObject
]
