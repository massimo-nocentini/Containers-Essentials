"
I take the place of a value that a notebook hides: `CTNotebookKeyedValuedOrderedCollection>>#hide:because:` makes me, with the value as my `topic` and the reason as my `text`. I am drawn as the text, in Markdown, gray and italic, instead of the outliners of the value.
"
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

	^ RSPangoMarkup new
		  font: PangoLogicalFontManager pangoSans;
		  text:
			  '<span font_style="italic" font_size="smaller" foreground="gray">'
			  , markup , '</span>';
		  yourself
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
