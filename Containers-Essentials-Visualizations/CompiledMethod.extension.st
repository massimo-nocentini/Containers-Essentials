Extension { #name : #CompiledMethod }

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledMethod >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCompiledMethod: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledMethod >> asDefaultShapeForWalker: aWalker [

	| formattedCode pangoMicVisitor font text comments mic markup docStringShape codeShape shapeGroup |
	pangoMicVisitor := PangoMarkupMicrodownVisitor new.

	font := LogicalFont fontconfigPharoMonospacePointSize:
		        StandardFonts codeFont pointSize.

	comments := OrderedCollection new.

	formattedCode := self ast comments
		                 inject: self sourceCode
		                 into: [ :code :commentNode |
			                 comments add:
				                 commentNode sourceCode allButFirstAndLast.

			                 code
				                 copyReplaceAll: commentNode sourceCode
				                 with: '' ].

	mic := Microdown parse: (String cr , String cr join: comments).

	markup := pangoMicVisitor visit: mic.

	docStringShape := markup asRSPangoMarkupUsingFont:
		                  (LogicalFont fontconfigPharoSansSerifPointSize:
			                   StandardFonts defaultFont pointSize).
	docStringShape := RSComposite new
		                  shapes: { docStringShape };
		                  yourself.

	formattedCode := (RBParser parseMethod: formattedCode) formattedCode
		                 fixEmptyLinesForPango
		                 replaceAllTabsWithSpacesForPango.

	text := self inspectionSource
		        text: formattedCode;
		        textWithStyle.

	codeShape := text asRSPangoTextUsingFont: font.
	codeShape := RSComposite new
		             shapes: { codeShape };
		             yourself.

	shapeGroup := RSGroup new
		              add: docStringShape;
		              add: codeShape;
		              yourself.

	RSLocation new
		above;
		stick: docStringShape on: codeShape.


	RSAlignment new
		shapes: shapeGroup;
		left.

	^ shapeGroup asShapeFor: self
]
