Extension { #name : #CompiledMethod }

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledMethod >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCompiledMethod: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledMethod >> asDefaultShapeForWalker: aWalker [

	| presenter lines text from |
	presenter := self inspectionSource.

	"Adjust the test to show the formatted version of the source code"
	presenter text:
		(self formattedCode copyReplaceAll: String tab with: '   ')
			fixEmptyLinesForPango.

	lines := presenter text lines asOrderedCollection.

	lines
		addFirst: ' ';
		addFirst: ('"{1}, protocol {2}"' format: {
						 self methodClassName.
						 self protocol }).

	presenter text: (String cr join: lines).

	text := presenter textWithStyle.

	from := 1.
	text
		addAttribute: TextEmphasis italic
		from: from
		to: from + lines first size - 1.

	text
		addAttribute: TextColor gray
		from: from
		to: from + lines first size - 1.

	from := 2.
	text
		addAttribute: TextEmphasis bold
		from: from
		to: from + self methodClassName size - 1.

	from := 1 + self methodClassName size + ', protocol ' size + 1.
	text
		addAttribute: TextEmphasis underlined
		from: from
		to: from + self protocol size - 1.

	^ (text asRSPangoTextUsingFont: StandardFonts codeFont)
		  model: self;
		  yourself
]
