Extension { #name : #Integer }

{ #category : #'*Containers-Essentials-Visualizations' }
Integer >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitInteger: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Integer >> asShapeBRGCDots [

	^ self asShapeBinaryDots: (self bitBRGC printStringBase: 2) asArray
]

{ #category : #'*Containers-Essentials-Visualizations' }
Integer >> asShapeBinaryDots [

	^ self asShapeBinaryDots: (self printStringBase: 2) asArray
]

{ #category : #'*Containers-Essentials-Visualizations' }
Integer >> asShapeBinaryDots: repr [

	| dots |
	dots := repr collect: [ :each | 
		        | int |
		        int := Integer readFrom: each asString.
		        RSCircle new
			        model: int;
			        color: Color white;
			        withBorder;
			        yourself: [ :c | 
				        c color: (int
							         ifZero: [ Color white ]
							         ifOne: [ c border color ]
							         ifTwo: [ 
								         c border
									         color: Color black;
									         color ]
							         otherwise: [ Error signal ]) ] ].

	RSHorizontalLineLayout new
		gapSize: Float goldenRatio;
		on: dots.

	^ RSComposite new
		  model: repr;
		  shapes: dots;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Integer >> asShapeSkewDots [

	^ self asShapeBinaryDots: (Array streamContents: [ :aStream | 
			   self skewBinaryCanonicalDenseRepresentation reversed do: [ :each | 
				   aStream nextPutAll: each asString ] ])
]
