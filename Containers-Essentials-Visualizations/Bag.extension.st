Extension { #name : #Bag }

{ #category : #'*Containers-Essentials-Visualizations' }
Bag >> asShapeHistogram [

	| elements occurrences size |
	elements := OrderedCollection new.
	occurrences := OrderedCollection new.

	self doWithOccurrences: [ :each :count | 
		elements add: each.
		occurrences add: count ].

	size := elements size.

	^ RSComposite new shapes: (RSChart new
			   addPlot: (RSHorizontalBarPlot new
					    x: occurrences reversed y: (1 to: size);
					    color: Color gray translucent;
					    yourself);
			   addDecoration: RSHorizontalTick new;
			   addDecoration: (RSVerticalTick new
					    configuration: (RSTickConfiguration new
							     numberOfTicks: elements size;
							     labelConversion: [ :index | 
								     (index between: 1 and: elements size)
									     ifTrue: [ (elements at: size - index + 1) asString ]
									     ifFalse: [ '' ] ];
							     yourself);
					    yourself);
			   build;
			   shapes)
]
