Extension { #name : #Integer }

{ #category : #'*Containers-Essentials-Visualizations' }
Integer >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitInteger: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Integer >> asShapeBRGCDots: aDfsWalker [

	^ self
		  asShapeBinaryDots: (self bitBRGC printStringBase: 2) asArray
		  walker: aDfsWalker
]

{ #category : #'*Containers-Essentials-Visualizations' }
Integer >> asShapeBinaryDots: aDfsWalker [

	^ self
		  asShapeBinaryDots: (self printStringBase: 2) asArray
		  walker: aDfsWalker
]

{ #category : #'*Containers-Essentials-Visualizations' }
Integer >> asShapeBinaryDots: repr walker: aDfsWalker [

	| dots radiusOrPadding |
	radiusOrPadding := aDfsWalker shapeBuilder radiusOrPadding.

	dots := repr collect: [ :each | 
		        | int circle color |
		        int := Integer readFrom: each asString.

		        circle := RSCircle new
			                  model: int;
			                  radius: radiusOrPadding * 2;
			                  color: Color white;
			                  withBorder;
			                  yourself.

		        color := int
			                 ifZero: [ Color white ]
			                 ifOne: [ circle border color ]
			                 ifTwo: [ 
				                 circle border
					                 color: Color black;
					                 color ]
			                 otherwise: [ Error signal ].

		        circle color: color.

		        circle ].

	RSHorizontalLineLayout new
		gapSize: radiusOrPadding / 2;
		on: dots.

	^ RSComposite new
		  model: repr;
		  shapes: dots;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Integer >> asShapeSkewDots: aDfsWalker [

	^ self
		  asShapeBinaryDots: (Array streamContents: [ :aStream | 
				   self skewBinaryCanonicalDenseRepresentation reversed do: [ 
					   :each | aStream nextPutAll: each asString ] ])
		  walker: aDfsWalker
]
