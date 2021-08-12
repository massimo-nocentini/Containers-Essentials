Class {
	#name : #CTObjectRefsShapeBuilder,
	#superclass : #Object,
	#instVars : [
		'senderVisit'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #visiting }
CTObjectRefsShapeBuilder >> object: anObject describedBy: aDescriptor descriptors: descriptors extent: width shape: mineShape [

	| shapes boxedCompositeShape compositeShape contentLocation classLabel padding |
	padding := self radiusOrPadding.

	shapes := descriptors collect: [ :slotDescriptor | 
		          | varLabel valueBox valueLabel valueShape |
		          "Unpacking."
		          varLabel := slotDescriptor varLabel.
		          valueLabel := slotDescriptor valueLabel.
		          valueBox := slotDescriptor valueBox.

		          valueBox width: width.

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

	classLabel := aDescriptor header value: anObject.

	contentLocation := shapes
		                   ifEmpty: [ 
			                   | shape x |
			                   shape := senderVisit
				                            quotedShapesAt: anObject
				                            ifPresent: [ :aQuotedShape | 
					                            classLabel := aDescriptor header 
						                                          value:
						                                          aQuotedShape model.
					                            aQuotedShape ]
				                            ifAbsent: [ 
				                            aDescriptor multilineLabelShapeOf:
					                            anObject ].

			                   x := shape extent x max: classLabel extent x.
			                   shape extent: x @ shape extent y.

			                   shapes := Array with: shape.

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
		                       extent:
			                       (compositeShape extent x max:
					                        classLabel extent x)
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
		stick: classLabel on: boxedCompositeShape.

	RSAlignment new
		shapes: { 
				classLabel.
				boxedCompositeShape };
		left.

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

{ #category : #visiting }
CTObjectRefsShapeBuilder >> radiusOrPadding [

	^ Float goldenRatio double
]

{ #category : #visiting }
CTObjectRefsShapeBuilder >> senderVisit: anObject [

	senderVisit := anObject
]
