Class {
	#name : 'QuoRemComplementary',
	#superclass : 'Magnitude',
	#instVars : [
		'a',
		'b',
		'ratio',
		'quo',
		'rem'
	],
	#category : 'Containers-Essentials-Numbers',
	#package : 'Containers-Essentials',
	#tag : 'Numbers'
}

{ #category : 'as yet unclassified' }
QuoRemComplementary class >> a: a b: b [

	^ self basicNew
		  a: a;
		  b: b;
		  initialize;
		  yourself
]

{ #category : 'testing' }
QuoRemComplementary >> < aMagnitude [

	"Answer whether the receiver is less than the argument."

	^ self value < aMagnitude
]

{ #category : 'comparing' }
QuoRemComplementary >> = aMagnitude [

	"Compare the receiver with the argument and answer with true if the 
	receiver is equal to the argument. Otherwise answer false."

	^ self value = aMagnitude
]

{ #category : 'accessing' }
QuoRemComplementary >> a [

	^ a
]

{ #category : 'accessing' }
QuoRemComplementary >> a: anObject [

	a := anObject
]

{ #category : 'as yet unclassified' }
QuoRemComplementary >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitQuoRemComplementary: self
]

{ #category : 'converting' }
QuoRemComplementary >> asPointWithRespectToRem [

	^ (1 @ self quo negated) negated
]

{ #category : 'as yet unclassified' }
QuoRemComplementary >> asShapeDots [

	| shapes |
	shapes := (1 to: self numberOfDots) collect: [ :each | 
		          RSCircle new
			          withBorder;
			          color: Color white;
			          yourself ].

	rem ifNegative: [ 
		(1 to: rem negated) do: [ :i | 
			(shapes at: shapes size + (1 - i)) sameColorAsBorderColor ] ].

	RSGridLayout new
		gapSize: Float goldenRatio double;
		lineItemsCount: b;
		on: shapes.

	^ RSComposite new
		  model: self;
		  shapes: shapes;
		  yourself
]

{ #category : 'accessing' }
QuoRemComplementary >> b [

	^ b
]

{ #category : 'accessing' }
QuoRemComplementary >> b: anObject [

	b := anObject
]

{ #category : 'comparing' }
QuoRemComplementary >> hash [

	"Hash must be redefined whenever = is redefined."

	^ self value hash
]

{ #category : 'accessing' }
QuoRemComplementary >> initialize [

	ratio := a / b.

	quo := self value ceiling.
	rem := a - (quo * b)
]

{ #category : 'as yet unclassified' }
QuoRemComplementary >> numberOfDots [

	^ b * quo
]

{ #category : 'as yet unclassified' }
QuoRemComplementary >> printOn: aStream [

	aStream
		nextPutAll: a asString;
		nextPutAll: ' = ';
		nextPutAll: quo asString;
		nextPutAll: '·';
		nextPutAll: b asString.

	rem
		ifNegative: [ 
			aStream
				nextPutAll: ' - ';
				nextPutAll: rem negated asString ]
		ifZero: [  ]
		ifPositive: [ 
			aStream
				nextPutAll: ' + ';
				nextPutAll: rem asString ]
]

{ #category : 'accessing' }
QuoRemComplementary >> quo [

	^ quo
]

{ #category : 'accessing' }
QuoRemComplementary >> rem [

	^ rem
]

{ #category : 'converting' }
QuoRemComplementary >> value [

	^ ratio
]
