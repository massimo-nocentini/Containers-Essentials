Extension { #name : #CompiledMethod }

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledMethod >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCompiledMethod: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledMethod >> asDefaultShapeForWalker: aWalker [

	| formattedCode pangoMicVisitor font text comments markup docStringShape codeShape shapeGroup defString yOffset |
	pangoMicVisitor := PangoMarkupMicrodownVisitor new.

	font := LogicalFont fontconfigPharoMonospacePointSize:
		        StandardFonts codeFont pointSize.

	defString := String streamContents: [ :stream |
		             stream
			             <<
				             '<span font_family="Source Sans Pro" font_size="larger"><b>';
			             << '<span font_family="Source Code Pro">';
			             << self methodClassName;
			             << '</span>';
			             << '</b>, protocol <i><u>';
			             << self protocol;
			             << '</u></i>.</span>' ].

	comments := OrderedCollection new.

	formattedCode := self ast comments
		                 inject: self sourceCode
		                 into: [ :code :commentNode |
			                 comments add:
				                 commentNode sourceCode allButFirstAndLast.

			                 code
				                 copyReplaceAll: commentNode sourceCode
				                 with: '' ].

	markup := comments ifEmpty: [ String empty ] ifNotEmpty: [
		          | mic commentsMarkup |
		          mic := Microdown parse:
			                 (String cr , String cr join: comments).

		          commentsMarkup := pangoMicVisitor visit: mic.

		          String cr , String cr , commentsMarkup ].

	markup := '<span foreground="gray">' , defString , markup , '</span>'.

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
		center;
		move: docStringShape on: codeShape.

	yOffset := 5 * Float goldenRatio.

	docStringShape width > codeShape width
		ifTrue: [
			codeShape translateBy:
				(docStringShape width - codeShape width) negated halved @ yOffset ]
		ifFalse: [
			docStringShape translateBy:
				(codeShape width - docStringShape width) negated halved
				@ yOffset negated ].

	^ shapeGroup asShapeFor: self
]
