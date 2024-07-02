Extension { #name : 'CompiledMethod' }

{ #category : '*Containers-Essentials-Visualizations' }
CompiledMethod >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCompiledMethod: self
]

{ #category : '*Containers-Essentials-Visualizations' }
CompiledMethod >> asDefaultShapeForWalker: aWalker descriptor: descriptor [

	| formattedCode font text comments codeShape shapeGroup defString headerShape |
	descriptor leftAlignValueShapeWithinItsBox.
	font := PangoLogicalFontManager pangoMonospace.

	defString := String streamContents: [ :stream |
		             stream
			             << '<span foreground="gray" font_family="';
			             << PangoLogicalFontManager pangoSans familyName;
			             << '" font_size="161.8%"><b>';
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

	headerShape := RSPangoMarkup new
		               text: defString;
		               asCompositeShape.

	comments := OrderedCollection new.

	formattedCode := self ast comments
		                 inject: self sourceCode
		                 into: [ :code :commentNode |
			                 comments add:
				                 commentNode sourceCode allButFirstAndLast.

			                 code
				                 copyReplaceAll: commentNode sourceCode
				                 with: '' ].

	formattedCode := (RBParser parseMethod: formattedCode) formattedCode
		                 replaceAllTabsWithThreeSpaces.

	text := self inspectionSource
		        text: formattedCode;
		        textWithStyle.

	codeShape := text asRSPangoShapeUsingFont: font.

	shapeGroup := RSGroup new
		              add: headerShape;
		              add: codeShape;
		              yourself.

	comments ifNotEmpty: [
		| docStringShape mic maxWidth separatorLine |
		comments := comments collect: [ :comment |
			            '{{<span foreground="gray">}}' , comment
			            , '{{</span>}}' ].

		mic := Microdown parse: (String cr , String cr join: comments).

		docStringShape := PangoMarkupMicrodownVisitor new
			                  visit: mic;
			                  asRSPangoShapeUsingFont:
				                  PangoLogicalFontManager pangoSerif.

		shapeGroup add: docStringShape.

		maxWidth := shapeGroup
			            inject: 0
			            into: [ :maxWidthSoFar :each |
			            each width max: maxWidthSoFar ].

		separatorLine := RSLine new
			                 startPoint: 0 @ 0;
			                 endPoint: maxWidth + Float goldenRatio @ 0.0;
			                 color: Smalltalk ui theme borderColor;
			                 yourself.

		shapeGroup add: separatorLine beforeIndex: shapeGroup size ].

	RSVerticalLineLayout new
		verticalGap: Float goldenRatio;
		alignLeft;
		on: shapeGroup.

	^ shapeGroup asShapeFor: self
]
