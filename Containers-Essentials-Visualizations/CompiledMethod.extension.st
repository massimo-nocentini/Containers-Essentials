Extension { #name : 'CompiledMethod' }

{ #category : '*Containers-Essentials-Visualizations' }
CompiledMethod >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCompiledMethod: self
]

{ #category : '*Containers-Essentials-Visualizations' }
CompiledMethod >> asDefaultShapeForWalker: aWalker descriptor: descriptor [
	"
![caption with space and dot...](https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png)
"

	| formattedCode font text comments docStringShape codeShape shapeGroup defString yOffset headerShape |
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
				                  asRSPangoShapeUsingFont: LogicalFont pangoSerif
			                  "String cr , String cr , commentsMarkup" ].

	formattedCode := (RBParser parseMethod: formattedCode) formattedCode
		                 replaceAllTabsWithThreeSpaces.

	text := self inspectionSource
		        text: formattedCode;
		        textWithStyle.

	codeShape := text asRSPangoShapeUsingFont: font.

	shapeGroup := RSGroup new
		              add: headerShape;
		              add: docStringShape;
		              add: codeShape;
		              yourself.

	RSVerticalLineLayout new
		alignLeft;
		on: shapeGroup.

	"RSLocation new
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
"
	^ shapeGroup asShapeFor: self
]
