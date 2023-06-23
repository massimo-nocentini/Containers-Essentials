Class {
	#name : #CTNotebookComment,
	#superclass : #Object,
	#instVars : [
		'text',
		'topic'
	],
	#category : #'Containers-Essentials-Outliner-Presenters'
}

{ #category : #converting }
CTNotebookComment >> asDefaultShapeForWalker: walker [

	| markup font |
	font := LogicalFont fontconfigPharoSans.

	markup := Microdown asPangoMarkupString: self text.

	^ '<span font_style="italic" font_size="smaller" foreground="gray">'
	  , markup , '</span>' asRSPangoMarkupUsingFont: font
]

{ #category : #accessing }
CTNotebookComment >> text [

	^ text
]

{ #category : #accessing }
CTNotebookComment >> text: anObject [

	text := anObject
]

{ #category : #accessing }
CTNotebookComment >> topic [

	^ topic
]

{ #category : #accessing }
CTNotebookComment >> topic: anObject [

	topic := anObject
]
