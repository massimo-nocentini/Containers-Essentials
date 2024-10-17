Extension { #name : 'CompiledMethod' }

{ #category : '*Containers-Essentials-Visualizations' }
CompiledMethod >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCompiledMethod: self
]

{ #category : '*Containers-Essentials-Visualizations' }
CompiledMethod >> asDefaultShapeForWalker: aWalker descriptor: descriptor [

	| formattedCode monospaceFont text comments codeShape shapeGroup defString headerShape |
	descriptor leftAlignValueShapeWithinItsBox.
	monospaceFont := PangoLogicalFontManager pangoMonospace.

	defString := String streamContents: [ :stream |
		             stream
			             << '<span font_size="161.8%" foreground="gray">';
			             << '<b>';
			             << '<span font_family="';
			             << monospaceFont familyName;
			             << '">';
			             << self methodClassName;
			             << '</span>';
			             << '</b>';
			             << ', protocol <i><u>'.

		             self protocol isUnclassifiedProtocol ifTrue: [
			             stream << '<span foreground="red">' ].

		             stream << self protocol name.

		             self protocol isUnclassifiedProtocol ifTrue: [
			             stream << '</span>' ].

		             stream << '</u></i>.</span>' ].

	headerShape := RSPangoMarkup new
		               font: PangoLogicalFontManager pangoSans;
		               text: defString;
		               yourself.

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

	codeShape := text asRSPangoShapeUsingFont: monospaceFont.

	shapeGroup := RSGroup new
		              add: headerShape;
		              add: codeShape;
		              yourself.

	comments ifNotEmpty: [
		| docStringShape mic maxWidth |
		comments := comments collect: [ :comment |
			            '{{<span foreground="gray">}}' , comment
			            , '{{</span>}}' ].

		mic := Microdown parse: (String cr , String cr join: comments).

		docStringShape := PangoMarkupMicrodownVisitor new
			                  visit: mic;
			                  asRSPangoShapeUsingFont:
				                  PangoLogicalFontManager pangoSerif.

		shapeGroup add: docStringShape beforeIndex: 2.

		maxWidth := shapeGroup
			            inject: 0
			            into: [ :maxWidthSoFar :each |
			            each width max: maxWidthSoFar ] ].

	RSVerticalLineLayout new
		verticalGap: headerShape height * Float silverRatio;
		alignLeft;
		on: shapeGroup.

	^ shapeGroup asShapeFor: self
]
