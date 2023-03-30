Extension { #name : #CompiledMethod }

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledMethod >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCompiledMethod: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledMethod >> asDefaultShapeForWalker: aWalker [

	| presenter lines text |
	presenter := self inspectionSource.

	"Adjust the test to show the formatted version of the source code"
	presenter text: self formattedCode.

	lines := presenter text lines
		         collect: [ :l |
			         l
				         ifEmpty: [ ' ' ]
				         ifNotEmpty: [ l copyReplaceAll: String tab with: '   ' ] ]
		         as: OrderedCollection.

	lines addFirst: ('"{1}, protocol {2}"' format: {
				 self methodClassName.
				 self protocol }).

	presenter text: (String cr join: lines).

	text := presenter textWithStyle.

	text addAttribute: TextEmphasis italic from: 1 to: lines first size.

	text
		addAttribute: TextEmphasis underlined
		from: 1 + self methodClassName size + ', protocol ' size + 1
		to: 1 + self methodClassName size + ', protocol ' size
			+ self protocol size.

	text
		addAttribute: TextEmphasis bold
		from: 2
		to: 2 + self methodClassName size.

	text addAttribute: TextColor gray from: 1 to: lines first size.

	^ text asRSPangoText
		  model: self;
		  yourself
]
