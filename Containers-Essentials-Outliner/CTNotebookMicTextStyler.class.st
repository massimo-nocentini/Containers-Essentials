Class {
	#name : #CTNotebookMicTextStyler,
	#superclass : #MicTextStyler,
	#category : #'Containers-Essentials-Outliner-Presenters'
}

{ #category : #private }
CTNotebookMicTextStyler >> computeHeaderFonts [

	headerFonts := Array new: self headerFontSizes size.
	1 to: headerFonts size do: [ :index |
		headerFonts at: index put: (TextFontReference toFont:
				 (StandardFonts defaultFont pointSize:
					  (self headerFontSizes at: index))) ]
]

{ #category : #'composer styles' }
CTNotebookMicTextStyler >> crAfterHeaderLevel: level [
	"I return Text to make space after a header"

	^ (' ' , String cr) asText
]

{ #category : #'composer styles' }
CTNotebookMicTextStyler >> interBlockSpacing [
	"I return the space to be put between blocks, first cr to end block, second to make empty line"

	^ (' ' , String cr , ' ' , String cr) asText
]

{ #category : #'composer styles' }
CTNotebookMicTextStyler >> newLineBody [
	"return a newline"

	^ (' ' , String cr) asText
]

{ #category : #'composer styles' }
CTNotebookMicTextStyler >> newLineIfNotAlready [
	"return a newline if there is not already one"

	"Intended to be overridden to add extra newline or tab indentation of the following line"

	^ self newLineBody
]

{ #category : #'composer styles' }
CTNotebookMicTextStyler >> postTextTreatment: aText [

	^ aText asString fixEmptyLinesForPango asText
]
