Extension { #name : #QuoRemComplementary }

{ #category : #'*Containers-Essentials-Visualizations' }
QuoRemComplementary >> asShapeDots [

	| shapes |
	shapes := (1 to: b * quo) collect: [ :each | 
		          RSCircle new
			          withBorder;
			          color: Color white;
			          yourself ].

	rem
		ifNegative: [ 
			(1 to: rem negated) do: [ :i | 
				(shapes at: shapes size + (1 - i)) sameColorAsBorderColor ] ]
		ifZero: [  ]
		ifPositive: [  ].

	RSGridLayout on: shapes withLineItemsCount: b.

	^ RSComposite new
		  model: self;
		  shapes: shapes;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
QuoRemComplementary >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection , { 
		  (#asString asSlotDescriptor inline: true).
		  (#asShapeDots asSlotDescriptor
			   inline: true;
			   quote) }
]

{ #category : #'*Containers-Essentials-Visualizations' }
QuoRemComplementary >> printOn: aStream [

	aStream
		nextPutAll: a asString;
		nextPutAll: ' = ';
		nextPutAll: quo asString;
		nextPutAll: '·';
		nextPutAll: b asString.

	rem negative ifTrue: [ 
		aStream
			nextPutAll: ' - ';
			nextPutAll: rem negated asString ]
]
