"
I am a division of two integers, `a = quo·b + rem`, whose quotient is rounded up: `quo` is the ceiling of the fraction `a / b`, so `rem` is zero or negative when `b` is positive. `Integer>>#/%~` makes me.

```smalltalk
(21 /%~ 9) asString ""'21 = 3·9 - 6'""
```

I am also the superclass of `QuoRemStandard`, which rounds down, of `QuoRemMinimal`, which rounds to the nearest integer, and of `GreatestCommonDivisor`. As a `Magnitude` I stand for my `value`, the fraction `a / b`: I compare it with a number, when I am the receiver of `=` or `<`, and have the hash of it. A number does not know me: it answers false when it receives `=`, and `<` is an error. So are my `>`, `<=` and `>=`, which ask the number.

```smalltalk
(21 /%~ 9) = (7 / 3) ""true""
```

- `asShapeDots` draws `quo` rows of `b` dots, and fills those that exceed `a`.
- `asPointWithRespectToRem` answers the coefficients of `a` and `b`, as a point, in the linear combination that is `rem` negated.
"
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
