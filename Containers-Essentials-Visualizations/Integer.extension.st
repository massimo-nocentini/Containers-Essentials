Extension { #name : #Integer }

{ #category : #'*Containers-Essentials-Visualizations' }
Integer >> asShapeBinaryDots [

	| dots repr |
	repr := (self printStringBase: 2) asArray.
	
	dots := repr collect: [ :each | 
		        | int |
		        int := Integer readFrom: each asString.
		        RSCircle new
			        model: int;
			        color: Color white;
			        withBorder;
			        yourself: [ :c | 
				        int = 1 ifTrue: [ c color: c border color ] ] ].

	RSHorizontalLineLayout new
		gapSize: 0;
		on: dots.

	^ RSComposite new
		  model: repr;
		  shapes: dots;
		  yourself
]
