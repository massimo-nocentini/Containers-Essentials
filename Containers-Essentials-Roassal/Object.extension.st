Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Roassal' }
Object >> asDefaultShapeForWalker: aWalker [

	| text |
	text := SpCodePresenter new
		        beForScripting;
		        text: self fullPrintString;
		        textWithStyle.

	^ text asRSPangoTextUsingFont:
		  (LogicalFont fontconfigPharoMonospacePointSize:
			   StandardFonts codeFont pointSize)
]
