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

	^ (self a /% self value) asShapeSlotsDfsTree
]

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> asShapeDivisorOverGCD [

	^ (self b /% self value) asShapeSlotsDfsTree
]

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> asStringDiophantineEquation [

	| ax by comb |
	ax := RBMessageNode
		      receiver: (RBLiteralValueNode value: self point x)
		      selector: #*
		      arguments: { (RBVariableNode named: #a) }.

	by := RBMessageNode
		      receiver: (RBLiteralValueNode value: self point y)
		      selector: #*
		      arguments: { (RBVariableNode named: #b) }.

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
		  #point asSlotDescriptor.
		  (#asStringDiophantineEquation asSlotDescriptor inline: true) }
	  , (self value = 1
			   ifTrue: [ 
				   { 
					   (#inverseMultiplicativeOfa asSlotDescriptor inline: true).
					   (#inverseMultiplicativeOfb asSlotDescriptor inline: true) } ]
			   ifFalse: [ {  } ]) , { 
		  (#asShapeDiophantineEquation asSlotDescriptor
			   inline: true;
			   quote).

		  (#asShapeDividendOverGCD asSlotDescriptor
			   inline: true;
			   quote).
		  (#asShapeDivisorOverGCD asSlotDescriptor
			   inline: true;
			   quote).
		  #equations asSlotDescriptor.
		  #divisibility asSlotDescriptor }
]

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> inverseMultiplicativeOfa [

	| ax by i |
	i := self point x.
	[ i negative ] whileTrue: [ i := i + self b ].

	ax := RBMessageNode
		      receiver: (RBLiteralValueNode value: i)
		      selector: #*
		      arguments: { (RBVariableNode named: #a) }.

	by := RBMessageNode
		      receiver: ax
		      selector: #rem:
		      arguments: { (RBVariableNode named: #b) }.

	^ (RBMessageNode
		   receiver: by
		   selector: #=
		   arguments: { (RBLiteralValueNode value: self value) })
		  formattedCode
]

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> inverseMultiplicativeOfb [

	| ax by i |
	i := self point y.
	[ i negative ] whileTrue: [ i := i + self a ].

	ax := RBMessageNode
		      receiver: (RBLiteralValueNode value: i)
		      selector: #*
		      arguments: { (RBVariableNode named: #b) }.

	by := RBMessageNode
		      receiver: ax
		      selector: #rem:
		      arguments: { (RBVariableNode named: #a) }.

	^ (RBMessageNode
		   receiver: by
		   selector: #=
		   arguments: { (RBLiteralValueNode value: self value) })
		  formattedCode
]
