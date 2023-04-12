Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Roassal' }
Object >> asDefaultShapeForWalker: aWalker [

	| text script ast |
	script := self fullPrintString.

	ast := RBParser parseExpression: script onError: [ nil ].

	text := ast
		        ifNil: [ script fixEmptyLinesForPango asText ]
		        ifNotNil: [
			        SpCodePresenter new
				        beForScripting;
				        text: ast formattedCode fixEmptyLinesForPango;
				        textWithStyle ].

	^ text asRSPangoTextUsingFont:
		  (LogicalFont fontconfigPharoMonospacePointSize:
			   StandardFonts codeFont pointSize)
]
