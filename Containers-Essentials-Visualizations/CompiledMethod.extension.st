Extension { #name : 'CompiledMethod' }

{ #category : '*Containers-Essentials-Visualizations' }
CompiledMethod >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCompiledMethod: self
]

{ #category : '*Containers-Essentials-Visualizations' }
CompiledMethod >> asDefaultShapeForWalker: aWalker descriptor: descriptor [

	| formattedCode font text comments markup docStringShape codeShape shapeGroup defString yOffset |
	descriptor leftAlignValueShapeWithinItsBox.
	font := LogicalFont pangoMonospace.

	defString := String streamContents: [ :stream |
		             stream
			             << '<span font_family="';
			             << LogicalFont pangoSans familyName;
			             << '" font_size="larger"><b>';
			             << '<span font_family="';
			             << font familyName;
			             << '">';
			             << self methodClassName;
			             << '</span>';
			             << '</b>, protocol <i><u>'.

		             self protocol isUnclassifiedProtocol ifTrue: [
			             stream << '<span foreground="red">' ].

		             stream << self protocol name.

		             self protocol isUnclassifiedProtocol ifTrue: [
			             stream << '</span>' ].

		             stream << '</u></i>.</span>' ].

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

		          commentsMarkup := PangoMarkupMicrodownVisitor new
			                            visit: mic;
			                            pangoMarkup.

		          String cr , String cr , commentsMarkup ].

	markup := '<span foreground="gray">' , defString , markup , '</span>'.

	docStringShape := markup asRSPangoShapeUsingFont:
		                  LogicalFont pangoSerif.

	formattedCode := (RBParser parseMethod: formattedCode) formattedCode
		                 fixEmptyLinesForPango
		                 replaceAllTabsWithThreeSpaces.

	text := self inspectionSource
		        text: formattedCode;
		        textWithStyle.

	codeShape := text asRSPangoShapeUsingFont: font.

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
