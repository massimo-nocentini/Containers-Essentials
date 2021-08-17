Class {
	#name : #CTObjectRefsShapeBuilder,
	#superclass : #Object,
	#instVars : [
		'senderVisit',
		'metaColor',
		'metaFontSize',
		'metaExtent',
		'prototypeLabel',
		'goldenRatios'
	],
	#category : #'Containers-Essentials-Inspector'
}

{ #category : #accessing }
CTObjectRefsShapeBuilder >> box: aValue [

	^ RSBox new
		  model: aValue;
		  color: metaColor translucent lighter lighter;
		  cornerRadius: self radiusOrPadding;
		  yourself
]

{ #category : #initialization }
CTObjectRefsShapeBuilder >> initialize [

	super initialize.

	goldenRatios := 10 goldenRatios.

	self prototypeLabel: (RSLabel new
			 model: nil;
			 fontName: 'Source Code Pro';
			 yourself)
]

{ #category : #accessing }
CTObjectRefsShapeBuilder >> label: anObject var: selector [

	| composite var |
	var := selector.
	composite := var asString asMultilineLabelShape: (RSLabel new
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
					         commentComposite := aComment asMultilineLabelShape:
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
CTObjectRefsShapeBuilder >> labelForClass: aClass [

	^ RSLabel new
		  text: aClass name;
		  fontSize: metaFontSize;
		  color: metaColor;
		  when: RSMouseLeftClick do: [ :ev | aClass browse ];
		  yourself: [ :labelShape | 
			  aClass hasAbstractMethods ifTrue: [ labelShape italic ] ]
]

{ #category : #accessing }
CTObjectRefsShapeBuilder >> metaExtent [

	^ metaExtent
]

{ #category : #'as yet unclassified' }
CTObjectRefsShapeBuilder >> multilineLabel: anObject [

	^ anObject asString asMultilineLabelShape: prototypeLabel
]

{ #category : #visiting }
CTObjectRefsShapeBuilder >> object: anObject describedBy: aDescriptor descriptors: descriptors extent: widthsAssociation shape: mineShape [

	| shapes boxedCompositeShape compositeShape contentLocation classLabel padding boxWidth varWidth µ π slotWidth |
	padding := self radiusOrPadding.

	classLabel := self padShape:
		              (aDescriptor header: anObject shapeBuilder: self).

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

	shapes := descriptors collect: [ :slotDescriptor | 
		          | varLabel valueBox valueLabel valueShape |
		          "Unpacking."
		          varLabel := slotDescriptor varLabel.
		          valueLabel := slotDescriptor valueLabel.
		          valueBox := slotDescriptor valueBox.

		          valueBox width: boxWidth + π.

		          valueShape := valueLabel
			                        ifNil: [ 
				                        senderVisit
					                        fromShapesAt: valueBox
					                        put: mineShape.
				                        valueBox ]
			                        ifNotNil: [ 
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

	contentLocation := shapes
		                   ifEmpty: [ 
			                   | shape x |
			                   shape := senderVisit
				                            quotedShapesAt: anObject
				                            ifPresent: [ :aQuotedShape | 
					                            classLabel := aDescriptor
						                                          header:
						                                          aQuotedShape model
						                                          shapeBuilder: self.
					                            aQuotedShape ]
				                            ifAbsent: [ 
				                            self multilineLabel: anObject ].

			                   x := shape extent x max: classLabel extent x.
			                   shape extent: x @ shape extent y.

			                   shapes := Array with: (self padShape: shape).

			                   RSLocation new
				                   inner;
				                   left;
				                   yourself ]
		                   ifNotEmpty: [ 
			                   RSLocation new
				                   inner;
				                   right;
				                   yourself ].

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

	contentLocation stick: compositeShape on: boxedCompositeShape.

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

	"RSAlignment new
		shapes: { 
				classLabel.
				boxedCompositeShape };
		left."

	^ mineShape
		  shapes: { 
				  classLabel.
				  boxedCompositeShape };
		  yourself
]

{ #category : #visiting }
CTObjectRefsShapeBuilder >> outline: anObject [

	^ RSComposite new
		  model: anObject;
		  yourself
]

{ #category : #accessing }
CTObjectRefsShapeBuilder >> padShape: aShape [

	| ratio |
	ratio := (goldenRatios at: 6) half.

	^ RSComposite new
		  shapes: { aShape };
		  padding: (aShape width @ aShape height * ratio max:
					   self radiusOrPadding asPoint);
		  yourself
]

{ #category : #accessing }
CTObjectRefsShapeBuilder >> prototypeLabel: aLabel [

	(prototypeLabel := aLabel) copy in: [ :aShape | 
		aShape text: 'Ggg'.
		metaExtent := (self padShape: aShape) extent.
		metaColor := aShape color lighter lighter lighter.
		metaFontSize := aShape fontSize * Float silverRatio ]
]

{ #category : #visiting }
CTObjectRefsShapeBuilder >> radiusOrPadding [

	^ Float goldenRatio double
]

{ #category : #visiting }
CTObjectRefsShapeBuilder >> senderVisit: anObject [

	senderVisit := anObject
]
