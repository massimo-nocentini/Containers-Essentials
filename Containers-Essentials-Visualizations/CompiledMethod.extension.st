Extension { #name : 'CompiledMethod' }

{ #category : '*Containers-Essentials-Visualizations' }
CompiledMethod >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCompiledMethod: self
]

{ #category : '*Containers-Essentials-Visualizations' }
CompiledMethod >> asDefaultShapeForWalker: aWalker descriptor: descriptor [

	| formattedCode font text comments docStringShape codeShape shapeGroup defString headerShape maxWidth controlPoints random separatorLine |
	descriptor leftAlignValueShapeWithinItsBox.
	font := LogicalFont pangoMonospace.

	defString := String streamContents: [ :stream |
		             stream
			             << '<span foreground="gray" font_family="';
			             << LogicalFont pangoSans familyName;
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

	docStringShape := comments
		                  ifEmpty: [ RSComposite ghost: comments ]
		                  ifNotEmpty: [
			                  | mic |
			                  comments := comments collect: [ :comment |
				                              '{{<span foreground="gray">}}'
				                              , comment , '{{</span>}}' ].

			                  mic := Microdown parse:
				                         (String cr , String cr join: comments).

			                  PangoMarkupMicrodownVisitor new
				                  visit: mic;
				                  asRSPangoShapeUsingFont: LogicalFont pangoSerif ].

	formattedCode := (RBParser parseMethod: formattedCode) formattedCode
		                 replaceAllTabsWithThreeSpaces.

	text := self inspectionSource
		        text: formattedCode;
		        textWithStyle.

	codeShape := text asRSPangoShapeUsingFont: font.

	shapeGroup := RSGroup new
		              add: headerShape;
		              add: codeShape;
		              add: docStringShape;
		              yourself.

	maxWidth := shapeGroup
		            inject: 0
		            into: [ :maxWidthSoFar :each |
		            each width max: maxWidthSoFar ].

	controlPoints := (0 to: maxWidth) linspace: 10.

	random := RandomGaussian seed: 541.

	separatorLine := RSdeCasteljauLine new
		                 color: Color lightGray;
		                 controlPoints:
			                 (controlPoints collect: [ :each |
					                  each @ 0 + random next ]);
		                 from: codeShape;
		                 to: docStringShape;
		                 yourself.

	shapeGroup
		add: separatorLine;
		swap: shapeGroup size with: shapeGroup size - 1.

	RSVerticalLineLayout new
		alignLeft;
		on: shapeGroup.

	^ shapeGroup asShapeFor: self
]
