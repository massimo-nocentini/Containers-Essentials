"
I provide basic shape constructors to be assembled in an outliner shape.
"
Class {
	#name : #CTDfsVisitShapeBuilder,
	#superclass : #Object,
	#instVars : [
		'metaColor',
		'metaFontSize',
		'metaExtent',
		'prototypeLabel',
		'goldenRatios'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTDfsVisitShapeBuilder >> box: aValue [

	^ RSBox new
		  model: aValue;
		  color: metaColor translucent lighter lighter;
		  cornerRadius: self radiusOrPadding;
		  yourself
]

{ #category : #visiting }
CTDfsVisitShapeBuilder >> classShape: classShape noSlotsShape: noSlotsShape descriptors: slotRows extent: widthsAssociation shape: mineShape [

	| shapes boxedCompositeShape compositeShape classLabel padding boxWidth varWidth µ π slotWidth location |
	padding := self radiusOrPadding.

	classLabel := self pad: classShape.

	varWidth := widthsAssociation key.
	boxWidth := widthsAssociation value.

	(slotWidth := varWidth + boxWidth) < classLabel width ifTrue: [ 
		slotWidth
			isTo: classLabel width
			as: varWidth
			isTo: [ :w | varWidth := w ].
		slotWidth
			isTo: classLabel width
			as: boxWidth
			isTo: [ :w | boxWidth := w ] ].

	varWidth < boxWidth
		ifTrue: [ 
			µ := (goldenRatios at: 2)
				     isTo: boxWidth
				     as: (goldenRatios at: 3)
				     isTo: [ :x | 
					     | ratio |
					     ratio := goldenRatios first.
					     ((x - varWidth max: 1) log: ratio) * ratio ].

			π := 0 ]
		ifFalse: [ 
			µ := 0.
			π := (goldenRatios at: 2)
				     isTo: varWidth
				     as: (goldenRatios at: 3)
				     isTo: [ :x | x - boxWidth max: 0 ] ].

	shapes := slotRows collect: [ :slotRow | 
		          | varLabel valueBox valueLabel valueShape |
		          "Unpacking."
		          varLabel := slotRow var.
		          valueLabel := slotRow label.
		          valueBox := slotRow box.

		          valueBox width: boxWidth + π.

		          valueShape := valueLabel ifNil: [ valueBox ] ifNotNil: [ 
			                        RSLocation new
				                        inner;
				                        stick: valueLabel on: valueBox.
			                        RSComposite new
				                        shapes:
					                        (Array with: valueBox with: valueLabel);
				                        yourself ].

		          RSLocation new
			          left;
			          outer;
			          offset: padding negated @ 0;
			          stick: varLabel on: valueShape.

		          RSComposite new
			          shapes: (Array with: varLabel with: valueShape);
			          yourself ].

	RSVerticalLineLayout new
		verticalGap: padding;
		on: shapes.

	RSAlignment new
		shapes: shapes;
		right.

	location := RSLocation new inner.

	shapes
		ifEmpty: [ 
			| x |
			x := noSlotsShape extent x max: classLabel extent x.
			noSlotsShape extent: x @ noSlotsShape extent y.

			shapes := Array with: noSlotsShape.

			location center ]
		ifNotEmpty: [ location right ].

	compositeShape := RSComposite new
		                  shapes: shapes;
		                  padding: padding;
		                  yourself.

	boxedCompositeShape := RSBox new
		                       color: Color white;
		                       extent: { 
				                       (varWidth + µ + boxWidth + π
				                        + padding triple).
				                       compositeShape extent x.
				                       classLabel extent x } max
			                       @ compositeShape extent y;
		                       cornerRadius: padding;
		                       withBorder;
		                       yourself.

	mineShape propertyDfsBoxedSlotsShape: boxedCompositeShape.

	location stick: compositeShape on: boxedCompositeShape.

	boxedCompositeShape := RSComposite new
		                       shapes: { 
				                       boxedCompositeShape.
				                       compositeShape };
		                       yourself.

	RSLocation new
		above;
		left;
		offset: classLabel width @ 0;
		stick: classLabel on: boxedCompositeShape.

	^ mineShape
		  shapes: { 
				  classLabel.
				  boxedCompositeShape };
		  yourself
]

{ #category : #initialization }
CTDfsVisitShapeBuilder >> initialize [

	super initialize.

	goldenRatios := 10 goldenRatios.

	self prototypeLabel: (RSLabel new
			 model: nil;
			 fontName: 'Source Code Pro';
			 yourself)
]

{ #category : #accessing }
CTDfsVisitShapeBuilder >> label: anObject var: selector [

	| composite var |
	var := selector.
	composite := var asString asShapeMultilineLabel: (RSLabel new
			              color: Color black;
			              yourself).

	RSAlignment new
		shapes: composite shapes;
		right.

	(anObject class lookupSelector: var) ifNotNil: [ :cm | 
		cm firstComment ifNotEmpty: [ :firstComment | 
			| popup |
			popup := RSPopup new
				         shapeBuilder: [ :aComment | 
					         | commentComposite box |
					         commentComposite := aComment asShapeMultilineLabel:
							                             prototypeLabel.

					         box := RSBox new
						                withBorder;
						                color: Color veryVeryLightGray;
						                cornerRadius: self radiusOrPadding;
						                extent:
							                commentComposite extent + self radiusOrPadding.

					         RSLocation new center stick: commentComposite on: box.

					         RSComposite new
						         shapes: { 
								         box.
								         commentComposite };
						         yourself ];
				         model: firstComment;
				         yourself.

			composite addInteraction: popup ].

		composite when: RSMouseLeftClick do: [ :ev | cm browse ] ].

	^ composite
]

{ #category : #initialization }
CTDfsVisitShapeBuilder >> labelForClass: aClass [

	^ RSLabel new
		  text: aClass name;
		  fontSize: metaFontSize;
		  color: metaColor;
		  when: RSMouseLeftClick do: [ :ev | aClass browse ];
		  yourself: [ :labelShape | 
			  aClass hasAbstractMethods ifTrue: [ labelShape italic ] ]
]

{ #category : #accessing }
CTDfsVisitShapeBuilder >> metaExtent [

	^ metaExtent
]

{ #category : #accessing }
CTDfsVisitShapeBuilder >> multilineLabel: anObject [

	^ (anObject asString asShapeMultilineLabel: prototypeLabel)
		  model: anObject;
		  yourself
]

{ #category : #visiting }
CTDfsVisitShapeBuilder >> outline: anObject [

	^ RSComposite new
		  model: anObject;
		  yourself
]

{ #category : #accessing }
CTDfsVisitShapeBuilder >> pad: aShape [

	^ RSComposite new
		  shapes: { aShape };
		  padding: self radiusOrPadding;
		  yourself
]

{ #category : #accessing }
CTDfsVisitShapeBuilder >> prototypeLabel: aLabel [

	(prototypeLabel := aLabel) copy in: [ :aShape | 
		aShape text: 'Ggg'.
		metaExtent := (self pad: aShape) extent.
		metaColor := aShape color lighter lighter lighter.
		metaFontSize := aShape fontSize * Float silverRatio ]
]

{ #category : #visiting }
CTDfsVisitShapeBuilder >> radiusOrPadding [

	^ Float goldenRatio double
]
