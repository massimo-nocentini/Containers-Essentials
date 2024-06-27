Class {
	#name : 'CTNotebookComment',
	#superclass : 'Object',
	#instVars : [
		'text',
		'topic'
	],
	#category : 'Containers-Essentials-Outliner-Presenters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Presenters'
}

{ #category : 'converting' }
CTNotebookComment >> asDefaultShapeForWalker: walker descriptor: descriptor [

	| markup |
	markup := Microdown asPangoMarkupString: self text.

	^ '<span font_style="italic" font_size="smaller" foreground="gray">'
	  , markup , '</span>' asRSPangoShapeUsingFont:
		  PangoLogicalFontManager pangoSans
]

{ #category : 'testing' }
CTNotebookComment >> isNotebookHideReason [

	^ true
]

{ #category : 'accessing' }
CTNotebookComment >> text [

	^ text
]

{ #category : 'accessing' }
CTNotebookComment >> text: anObject [

	text := anObject
]

{ #category : 'accessing' }
CTNotebookComment >> topic [

	^ topic
]

{ #category : 'accessing' }
CTNotebookComment >> topic: anObject [

	topic := anObject
]
