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
