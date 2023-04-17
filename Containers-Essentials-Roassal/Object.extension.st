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

{ #category : #'*Containers-Essentials-Roassal' }
Object >> asStringPangoText [
	"Yields the `#asString` representation in a Pango text shape.

A list:
- This is a point
  - this another <span foreground='red'>hello</span>
    over two lines
- again at top level 
   over two lines

more"

	^ self asString fixEmptyLinesForPango asText asRSPangoTextUsingFont:
		  (LogicalFont fontconfigPharoSansPointSize:
			   StandardFonts defaultFont pointSize)
]
