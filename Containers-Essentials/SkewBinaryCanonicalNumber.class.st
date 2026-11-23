"
I am a natural number in the canonical skew binary form: a sum of weights, each a power of two minus one (1, 3, 7, 15 and so on), where only the two smallest weights may be equal. `Integer>>#asSkewBinaryCanonicalSparse` makes me.

My `representation` is a chain of links with the weights that are there, the smallest one first, or nil for zero.

```smalltalk
| six |
six := 6 asSkewBinaryCanonicalSparse.
six representation asArray. ""#(3 3)""
six increment representation asArray. ""#(7)""
six decrement representation asArray. ""#(1 1 3)""
six increment asInteger ""7""
```

`increment` and `decrement` look at the first two weights at most and answer another number, which shares the other links with me. `decrement` signals an `ArithmeticError` on zero.

A subclass can keep more than the weight in each link by overriding these hooks:

- `key:`, the weight of a link
- `incrementZero`, `incrementLastDigit`, `incrementDifferentAdjacentBits` and `incrementBy:onto:two:inARow:`, the cases of `increment`
- `decrementBitZeroOrTwo:by:onto:`, the case of `decrement` that splits a weight into two
"
Class {
	#name : 'SkewBinaryCanonicalNumber',
	#superclass : 'Object',
	#instVars : [
		'representation'
	],
	#category : 'Containers-Essentials-Numbers',
	#package : 'Containers-Essentials',
	#tag : 'Numbers'
}

{ #category : 'converting' }
SkewBinaryCanonicalNumber >> asInteger [

	| value |
	value := 0.
	representation do: [ :each | value := value + each ].
	^ value
]

{ #category : 'accessing' }
SkewBinaryCanonicalNumber >> cdr [
	^ self class new
		representation: representation nextLink;
		yourself
]

{ #category : 'creating' }
SkewBinaryCanonicalNumber >> cons: i [
	^ self cons: i onto: representation
]

{ #category : 'creating' }
SkewBinaryCanonicalNumber >> cons: i onto: aValueLink [
	^ self class new
		representation: i ~~> aValueLink;
		yourself
]

{ #category : 'decrement' }
SkewBinaryCanonicalNumber >> decrement [

	^ self
		  ifZero: [ ArithmeticError signal ]
		  ifNotZero: [ :aValueLink | 
			  | w |
			  w := self weight.
			  w = 1
				  ifTrue: [ self cdr ]
				  ifFalse: [ 
					  self
						  decrementBitZeroOrTwo: aValueLink value
						  by: w // 2
						  onto: aValueLink nextLink ] ]
]

{ #category : 'decrement' }
SkewBinaryCanonicalNumber >> decrementBitZeroOrTwo: aValue by: v onto: aRepresentation [

	^ self cons: v onto: v ~~> aRepresentation
]

{ #category : 'accessing' }
SkewBinaryCanonicalNumber >> ifZero: zBlock ifNotZero: nzBlock [
	^ representation ifNil: zBlock ifNotNil: nzBlock
]

{ #category : 'increment' }
SkewBinaryCanonicalNumber >> increment [

	^ self ifZero: [ self incrementZero ] ifNotZero: [ :aValueLink | 
		  aValueLink nextLink
			  ifNil: [ self incrementLastDigit ]
			  ifNotNil: [ :nextLink | 
				  | v w |
				  v := self key: aValueLink.
				  w := self key: nextLink.
				  v = w
					  ifTrue: [ 
						  self
							  incrementBy: 1 + v + w
							  onto: nextLink nextLink
							  two: aValueLink value
							  inARow: nextLink value ]
					  ifFalse: [ self incrementDifferentAdjacentBits ] ] ]
]

{ #category : 'increment' }
SkewBinaryCanonicalNumber >> incrementBy: weight onto: aRepresentation two: currentValue inARow: nextValue [

	^ self cons: weight onto: aRepresentation
]

{ #category : 'evaluating' }
SkewBinaryCanonicalNumber >> incrementDifferentAdjacentBits [

	^ self cons: 1
]

{ #category : 'increment' }
SkewBinaryCanonicalNumber >> incrementLastDigit [

	^ self cons: 1
]

{ #category : 'increment' }
SkewBinaryCanonicalNumber >> incrementZero [

	^ self cons: 1
]

{ #category : 'accessing' }
SkewBinaryCanonicalNumber >> key: aValueLink [
	^ aValueLink value
]

{ #category : 'accessing' }
SkewBinaryCanonicalNumber >> representation [
	^ representation
]

{ #category : 'accessing' }
SkewBinaryCanonicalNumber >> representation: aValueLink [
	representation := aValueLink
]

{ #category : 'accessing' }
SkewBinaryCanonicalNumber >> weight [
	^ self key: representation
]
