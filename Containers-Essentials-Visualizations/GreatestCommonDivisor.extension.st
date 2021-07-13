Extension { #name : #GreatestCommonDivisor }

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> asShapeDiophantineEquation [

	| r s shapes lines |
	self point x negative
		ifTrue: [ 
			r := self point y * self b.
			s := (self point x * self a) negated.
			lines := self b ]
		ifFalse: [ 
			r := self point x * self a.
			s := (self point y * self b) negated.
			lines := self a ].

	shapes := (1 to: r) collect: [ :each | 
		          RSCircle new
			          withBorder;
			          color: Color white;
			          yourself ].

	(1 to: s) do: [ :i | (shapes at: i) sameColorAsBorderColor ].

	RSGridLayout on: shapes withLineItemsCount: lines.

	^ RSComposite new
		  model: self;
		  shapes: shapes;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> asShapeDividendOverGCD [

	^ self a /% self value
]

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> asShapeDivisorOverGCD [

	^ self b /% self value
]

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> asStringDiophantineEquation [

	| ax by comb |
	ax := RBMessageNode
		      receiver: (RBLiteralValueNode value: self point x)
		      selector: #*
		      arguments: { (RBLiteralValueNode value: self a) }.

	by := RBMessageNode
		      receiver: (RBLiteralValueNode value: self point y)
		      selector: #*
		      arguments: { (RBLiteralValueNode value: self b) }.

	comb := RBMessageNode receiver: ax selector: #+ arguments: { by }.

	^ (RBMessageNode
		   receiver: comb
		   selector: #=
		   arguments: { (RBLiteralValueNode value: self value) })
		  formattedCode
]

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> instVarsNamesOrderedCollection [

	^ { 
		  #a asSlotDescriptor.
		  #b asSlotDescriptor.
		  #value asSlotDescriptor.
		  (#asString asSlotDescriptor inline: true).
		  #equations asSlotDescriptor.
		  #point asSlotDescriptor.
		  (#asStringDiophantineEquation asSlotDescriptor inline: true) }
	  , (self value = 1
			   ifTrue: [ 
				   { 
					   (#inverseMultiplicativeOfa asSlotDescriptor
						    inline: true;
						    quote: #asShapeSlotsDfsTree).
					   (#inverseMultiplicativeOfb asSlotDescriptor
						    inline: true;
						    quote: #asShapeSlotsDfsTree) } ]
			   ifFalse: [ 
				   { 
					   (#asShapeDividendOverGCD asSlotDescriptor
						    inline: true;
						    quote: #asShapeSlotsDfsTree).
					   (#asShapeDivisorOverGCD asSlotDescriptor
						    inline: true;
						    quote: #asShapeSlotsDfsTree) } ])
	".

		  #divisibility asSlotDescriptor"
	"(#asShapeDiophantineEquation asSlotDescriptor
			   inline: true;
			   quote)."
]

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> inverseMultiplicativeOf: a_b mul: j rem: mod [

	| ax by i |
	i := j.
	[ i negative ] whileTrue: [ i := i + mod ].

	ax := RBMessageNode
		      receiver: (RBLiteralValueNode value: i)
		      selector: #*
		      arguments: { (RBLiteralValueNode value: a_b) }.

	by := RBMessageNode
		      receiver: ax
		      selector: #rem:
		      arguments: { (RBLiteralValueNode value: mod) }.

	^ i -> (RBMessageNode
		   receiver: by
		   selector: #=
		   arguments: { (RBLiteralValueNode value: self value) })
		  formattedCode
]

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> inverseMultiplicativeOfa [

	^ self inverseMultiplicativeOf: self a mul: self point x rem: self b
]

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> inverseMultiplicativeOfb [

	^ self inverseMultiplicativeOf: self b mul: self point y rem: self a
]
