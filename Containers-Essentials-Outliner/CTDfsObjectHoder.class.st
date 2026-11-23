"
I hold an `object` so that its outliners are drawn inside the box of the slot where I am, instead of out of it: a `CTDfsWalker` always draws me inline, and my shape, aligned to the left of the box, is the one that a new walker makes from my object.

`CTNotebookKeyedValuedOrderedCollection` holds with me the values of the statements of a notebook.
"
Class {
	#name : 'CTDfsObjectHoder',
	#superclass : 'Object',
	#instVars : [
		'object'
	],
	#category : 'Containers-Essentials-Outliner-Presenters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Presenters'
}

{ #category : 'converting' }
CTDfsObjectHoder >> asDefaultShapeForWalker: walker descriptor: descriptor [

	descriptor leftAlignValueShapeWithinItsBox.

	^ object asShapeSlotsDfsTree: CTDfsWalker new
]

{ #category : 'testing' }
CTDfsObjectHoder >> isObjectHolder [

	^ true
]

{ #category : 'accessing' }
CTDfsObjectHoder >> object [

	^ object
]

{ #category : 'accessing' }
CTDfsObjectHoder >> object: anObject [

	object := anObject
]
