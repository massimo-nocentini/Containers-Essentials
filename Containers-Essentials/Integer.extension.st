Extension { #name : #Integer }

{ #category : #'*Containers-Essentials' }
Integer >> /% anObject [

	^ anObject quoRemInteger: self
]

{ #category : #'*Containers-Essentials' }
Integer >> /%< anObject [

	^ anObject quoRemMinimalInteger: self
]

{ #category : #'*Containers-Essentials' }
Integer >> /%~ anObject [

	^ anObject quoRemComplementaryInteger: self
]

{ #category : #'*Containers-Essentials' }
Integer >> >|< anObject [

	^ anObject greatestCommonDisivorInteger: self
]

{ #category : #'*Containers-Essentials' }
Integer >> \/ anObject [

	^ anObject mediantInteger: self
]

{ #category : #'*Containers-Essentials' }
Integer >> asBRGCCollection [

	^ (1 to: self) withBRGCIndexCollect: [ :each :index | index ]
]

{ #category : #'*Containers-Essentials' }
Integer >> asSkewBinaryCanonicalSparse [

	| skew |
	skew := SkewBinaryCanonicalNumber new.
	self timesRepeat: [ skew := skew increment ].
	^ skew
]

{ #category : #'*Containers-Essentials' }
Integer >> asStringAZaz [

	^ self positive
		  ifTrue: [ 
			  | repr skipInterval nextSkipInterval |
			  repr := self printStringBase: 52.

			  skipInterval := $0 asInteger to: $9 asInteger.
			  nextSkipInterval := $Z asInteger + 1 to: $a asInteger - 1.

			  String streamContents: [ :aStream | 
				  repr do: [ :each | 
					  | i |
					  i := each asInteger.

					  i := (nextSkipInterval includes: i)
						       ifTrue: [ i - nextSkipInterval first + $u asInteger ]
						       ifFalse: [ 
							       (skipInterval includes: i)
								       ifTrue: [ i - skipInterval first + $k asInteger ]
								       ifFalse: [ i ] ].

					  aStream nextPut: i asCharacter ] ] ]
		  ifFalse: [ Error signal ]
]

{ #category : #'*Containers-Essentials' }
Integer >> asStringBRGC [

	^ self bitBRGC printStringBase: 2
]

{ #category : #'*Containers-Essentials' }
Integer >> asStringBinary [

	^ self printStringBase: 2
]

{ #category : #'*Containers-Essentials' }
Integer >> asStringDecimal [

	^ self printString
]

{ #category : #'*Containers-Essentials' }
Integer >> asStringHex [

	^ self printStringHex
]

{ #category : #'*Containers-Essentials' }
Integer >> asStringOctal [

	^ self printStringBase: 8
]

{ #category : #'*Containers-Essentials' }
Integer >> asStringSkew [

	^ String streamContents: [ :aStream | 
		  self skewBinaryCanonicalDenseRepresentation reversed do: [ :each | 
			  aStream nextPutAll: each asString ] ]
]

{ #category : #'*Containers-Essentials' }
Integer >> asStringaz [

	^ self positive
		  ifTrue: [ 
			  | repr skipInterval upperCasesInterval |
			  repr := self printStringBase: 26.

			  skipInterval := $0 asInteger to: $9 asInteger.
			  upperCasesInterval := $A asInteger to: $Z asInteger.

			  String streamContents: [ :aStream | 
				  repr do: [ :each | 
					  | i |
					  i := each asInteger.

					  i := (skipInterval includes: i)
						       ifTrue: [ i - skipInterval first + $q asInteger ]
						       ifFalse: [ 
							       (upperCasesInterval includes: i)
								       ifTrue: [ i - upperCasesInterval first + $a asInteger ]
								       ifFalse: [ i ] ].

					  aStream nextPut: i asCharacter ] ] ]
		  ifFalse: [ Error signal ]
]

{ #category : #'*Containers-Essentials' }
Integer >> binaryCanonicalDenseRepresentation [
	^ self isZero
		  ifTrue: [ 0 ~~> nil ]
		  ifFalse: [ 
		  self binaryCanonicalDenseRepresentationWith: [ :v | v ] ]
]

{ #category : #'*Containers-Essentials' }
Integer >> binaryCanonicalDenseRepresentationWith: anAccumulatorBlock [

	^ self isZero
		  ifTrue: [ anAccumulatorBlock value: nil ]
		  ifFalse: [ 
			  self // 2 binaryCanonicalDenseRepresentationWith: [ 
				  :representation | 
				  anAccumulatorBlock value: self \\ 2 ~~> representation ] ]
]

{ #category : #'*Containers-Essentials' }
Integer >> bitAdd: anInteger [

	"See 'Matters Computational' (ftxbook) section 1.1.7, Average without overflow."

	"Use: x+y == ((x&y)<<1) + (x^y)."

	^ (self bitAnd: anInteger) << 1 + (self bitXor: anInteger)
]

{ #category : #'*Containers-Essentials' }
Integer >> bitAverage: anInteger [

	"See 'Matters Computational' (ftxbook) section 1.1.7, Average without overflow."

	"Use: x+y == (x^y) + ((x&y)<<1), that is: sum == sum_without_carries + carries."

	^ (self bitXor: anInteger) >> 1 + (self bitAnd: anInteger)
]

{ #category : #'*Containers-Essentials' }
Integer >> bitBRGC [

	^ self bitXor: self >> 1
]

{ #category : #'*Containers-Essentials' }
Integer >> bitInvert8 [
	"Answer the 8-bit complement of the receiver."

	| mask |
	mask := 16rFF.
	^ (self bitAnd: mask) bitXor: mask
]

{ #category : #'*Containers-Essentials' }
Integer >> bitToggle: anInteger do: aBlock [

	"See 'Matters Computational' (ftxbook) section 1.1.8, Toggling between values."

	| t x |
	t := self bitXor: anInteger.
	x := anInteger.

	^ aBlock value: [ x := x bitXor: t ]
]

{ #category : #'*Containers-Essentials' }
Integer >> catalan: k [

	^ (2 * self - k choose: self - k)
	  - (2 * self - k choose: self - k - 1)
]

{ #category : #'*Containers-Essentials' }
Integer >> catalanNumbers [

	^ self
		  ifPositive: [ 
			  (0 to: self - 1) collect: [ :each | 
				  (each double choose: each) / (each + 1) ] ]
		  ifNotPositive: [ Array empty ]
]

{ #category : #'*Containers-Essentials' }
Integer >> choose: k [
	^ (k positive and: [ self >= k ])
		ifTrue: [ self factorial / (k factorial * (self - k) factorial) ]
		ifFalse: [ 0 ]
]

{ #category : #'*Containers-Essentials' }
Integer >> dcMultiplyInteger: anInteger base: base [

	^ ((self between: 0 and: base - 1) and: [ 
		   anInteger between: 0 and: base - 1 ])
		  ifTrue: [ self multiplyNumber: anInteger ]
		  ifFalse: [ 
			  | x y yDigits |
			  (self numberOfDigitsInBase: base)
			  > (anInteger numberOfDigitsInBase: base)
				  ifTrue: [ 
					  x := self.
					  y := anInteger ]
				  ifFalse: [ 
					  x := anInteger.
					  y := self ].

			  yDigits := y numberOfDigitsInBase: base.

			  x
				  halves: [ :xHigh :xLow :xn :xl | 
					  y
						  halves: [ :yHigh :yLow :yn :yl | 
							  | p pp xyHigh xyLow exp |
							  p := (xHigh addNumber: xLow)
								       karatsuba: (yHigh addNumber: yLow)
								       base: base.
							  xyHigh := xHigh karatsuba: yHigh base: base.
							  xyLow := xLow karatsuba: yLow base: base.

							  exp := base ** xl.
							  pp := p subtractNumber: (xyHigh addNumber: xyLow).

							  "According to the Horner schema."
							  (((xyHigh multiplyNumber: exp) addNumber: pp) 
								   multiplyNumber: exp) addNumber: xyLow ]
						  at: xl
						  digits: yDigits
						  base: base ]
				  base: base ]
]

{ #category : #'*Containers-Essentials' }
Integer >> dcMultiplyIntegerQuick: anInteger base: base [

	^ ((self between: 0 and: base - 1) and: [ 
		   anInteger between: 0 and: base - 1 ])
		  ifTrue: [ self multiplyNumber: anInteger ]
		  ifFalse: [ 
			  | x y yDigits |
			  (self numberOfDigitsInBase: base)
			  > (anInteger numberOfDigitsInBase: base)
				  ifTrue: [ 
					  x := self.
					  y := anInteger ]
				  ifFalse: [ 
					  x := anInteger.
					  y := self ].

			  yDigits := y numberOfDigitsInBase: base.

			  x
				  halves: [ :xHigh :xLow :xn :xl | 
					  y
						  halves: [ :yHigh :yLow :yn :yl | 
							  | p pp xyHigh xyLow exp |
							  p := (xHigh bitAdd: xLow)
								       dcMultiplyIntegerQuick: (yHigh bitAdd: yLow)
								       base: base.
							  xyHigh := xHigh dcMultiplyIntegerQuick: yHigh base: base.
							  xyLow := xLow dcMultiplyIntegerQuick: yLow base: base.

							  exp := base ** xl.
							  pp := p subtractNumber: (xyHigh bitAdd: xyLow).

							  "According to the Horner schema."
							  (((xyHigh multiplyNumber: exp) bitAdd: pp) multiplyNumber:
								   exp) bitAdd: xyLow ]
						  at: xl
						  digits: yDigits
						  base: base ]
				  base: base ]
]

{ #category : #'*Containers-Essentials' }
Integer >> dcMultiplyIntegerSlow: anInteger base: base [

	^ ((self between: 0 and: base - 1) and: [ 
		   anInteger between: 0 and: base - 1 ])
		  ifTrue: [ self multiplyNumber: anInteger ]
		  ifFalse: [ 
			  | x y yDigits |
			  (self numberOfDigitsInBase: base)
			  > (anInteger numberOfDigitsInBase: base)
				  ifTrue: [ 
					  x := self.
					  y := anInteger ]
				  ifFalse: [ 
					  x := anInteger.
					  y := self ].

			  yDigits := y numberOfDigitsInBase: base.

			  x
				  halves: [ :xHigh :xLow :xn :xl | 
					  y
						  halves: [ :yHigh :yLow :yn :yl | 
							  | p pp xyHigh xyLow |
							  p := (xHigh addNumber: xLow)
								       dcMultiplyIntegerSlow: (yHigh addNumber: yLow)
								       base: base.
							  xyHigh := xHigh dcMultiplyIntegerSlow: yHigh base: base.
							  xyLow := xLow dcMultiplyIntegerSlow: yLow base: base.

							  pp := ((p subtractNumber: xyHigh) subtractNumber: xyLow) 
								        multiplyNumber: base ** xl.
							  ((xyHigh multiplyNumber: base ** xl double) addNumber: pp) 
								  addNumber: xyLow ]
						  at: xl
						  digits: yDigits
						  base: base ]
				  base: base ]
]

{ #category : #'*Containers-Essentials' }
Integer >> double [

	^ self << 1
]

{ #category : #'*Containers-Essentials' }
Integer >> eightBits [
	| byte |
	byte := self bitAnd: 16rff.
	^ (0 to: 7) collect: [ :i | (1 << i bitAnd: byte) ~= 0 ]
]

{ #category : #'*Containers-Essentials' }
Integer >> factorialRecursive [

	^ self > 0
		  ifTrue: [ 
		  self multiplyNumber: (self subtractNumber: 1) factorialRecursive ]
		  ifFalse: [ 
			  self = 0
				  ifTrue: [ 1 ]
				  ifFalse: [ self error: 'Not valid for negative integers' ] ]
]

{ #category : #'*Containers-Essentials' }
Integer >> fibonacciNumbers [

	^ self gibonacciNumbersFirst: 0 second: 1 do: [ :a :b | a + b ]
]

{ #category : #'*Containers-Essentials' }
Integer >> gibonacciNumbersFirst: first second: second do: aBlock [

	^ self
		  ifPositive: [ 
			  Array streamContents: [ :aStream | 
				  | a |
				  a := first.
				  aStream nextPut: a.
				  self > 1 ifTrue: [ 
					  | b |
					  b := second.
					  aStream nextPut: b.
					  3 to: self do: [ :each | 
						  | c v |
						  c := aBlock value: a value: b.
						  aStream nextPut: c.
						  a := b.
						  b := c ] ] ] ]
		  ifNotPositive: [ #(  ) ]
]

{ #category : #'*Containers-Essentials' }
Integer >> goldenRatiosGreater [

	^ self
		  gibonacciNumbersFirst: 1
		  second: Float goldenRatio
		  do: [ :a :b | a + b ]
]

{ #category : #'*Containers-Essentials' }
Integer >> goldenRatiosLower [

	^ self
		  gibonacciNumbersFirst: Float goldenRatio
		  second: 1
		  do: [ :a :b | a - b ]
]

{ #category : #'*Containers-Essentials' }
Integer >> greatestCommonDisivorInteger: anInteger [

	| max min |
	max := self max: anInteger.
	min := self min: anInteger.

	^ GreatestCommonDivisor a: max b: min
]

{ #category : #'*Containers-Essentials' }
Integer >> halves: aBlock at: l digits: n base: aBase [

	| low high lSucc |
	lSucc := l + 1.

	low := (1 to: l) inject: 0 into: [ :acc :i | 
		       | d |
		       d := (self digitAt: i base: aBase) * (aBase ** (i - 1)).
		       d + acc ].

	high := (lSucc to: n) inject: 0 into: [ :acc :i | 
		        | d |
		        d := (self digitAt: i base: aBase) * (aBase ** (i - lSucc)).
		        d + acc ].

	^ aBlock
		  value: high
		  value: low
		  value: n
		  value: l
]

{ #category : #'*Containers-Essentials' }
Integer >> halves: aBlock base: aBase [

	| n |
	n := self numberOfDigitsInBase: aBase.

	^ self
		  halves: aBlock
		  at: (n / 2) ceiling
		  digits: n
		  base: aBase
]

{ #category : #'*Containers-Essentials' }
Integer >> ifNotZero: nzBlock [
	^ self ifZero: #yourself ifNotZero: nzBlock
]

{ #category : #'*Containers-Essentials' }
Integer >> ifZero: zBlock [
	^ self ifZero: zBlock ifNotZero: #yourself
]

{ #category : #'*Containers-Essentials' }
Integer >> ifZero: zBlock ifNotZero: nzBlock [
	^ self = 0
		ifTrue: [ zBlock cull: self ]
		ifFalse: [ nzBlock cull: self ]
]

{ #category : #'*Containers-Essentials' }
Integer >> ifZero: zBlock ifOne: oBlock ifTwo: tBlock otherwise: eBlock [

	^ self = 0
		  ifTrue: zBlock
		  ifFalse: [ 
			  self = 1
				  ifTrue: oBlock
				  ifFalse: [ 
					  self = 2
						  ifTrue: tBlock
						  ifFalse: eBlock ] ]
]

{ #category : #'*Containers-Essentials' }
Integer >> karatsuba: anInteger base: base [

	^ ((self between: 0 and: base - 1) and: [ 
		   anInteger between: 0 and: base - 1 ])
		  ifTrue: [ self multiplyNumber: anInteger ]
		  ifFalse: [ 
			  | x y yDigits |
			  (self numberOfDigitsInBase: base)
			  > (anInteger numberOfDigitsInBase: base)
				  ifTrue: [ 
					  x := self.
					  y := anInteger ]
				  ifFalse: [ 
					  x := anInteger.
					  y := self ].

			  yDigits := y numberOfDigitsInBase: base.

			  x
				  halves: [ :xHigh :xLow :xn :xl | 
					  y
						  halves: [ :yHigh :yLow :yn :yl | 
							  | p pp xyHigh xyLow exp |
							  p := (xHigh addNumber: xLow)
								       karatsuba: (yHigh addNumber: yLow)
								       base: base.
							  xyHigh := xHigh karatsuba: yHigh base: base.
							  xyLow := xLow karatsuba: yLow base: base.

							  exp := base ** xl.
							  pp := p subtractNumber: (xyHigh addNumber: xyLow).

							  "According to the Horner schema."
							  (((xyHigh multiplyNumber: exp) addNumber: pp) 
								   multiplyNumber: exp) addNumber: xyLow ]
						  at: xl
						  digits: yDigits
						  base: base ]
				  base: base ]
]

{ #category : #'*Containers-Essentials' }
Integer >> kissingFractionLink: aLink [

	^ aLink
]

{ #category : #'*Containers-Essentials' }
Integer >> lucasNumbers [

	^ self gibonacciNumbersFirst: 2 second: 1 do: [ :a :b | a + b ]
]

{ #category : #'*Containers-Essentials' }
Integer >> mediantFraction: aFraction [

	^ aFraction numerator + self / (aFraction denominator + self)
]

{ #category : #'*Containers-Essentials' }
Integer >> mediantInteger: anInteger [

	^ self + anInteger / 2
]

{ #category : #'*Containers-Essentials' }
Integer >> nextEven [

	"See 'Matters Computational' (ftxbook) section 1.1.9, 
	 Next or previous even or odd value, optimized versions."

	^ (self bitOr: 1) + 1
]

{ #category : #'*Containers-Essentials' }
Integer >> nextEvenOrSelf [

	"See 'Matters Computational' (ftxbook) section 1.1.9, 
	 Next or previous even or odd value, optimized versions."

	^ self + 1 bitAnd: 1 bitInvert
]

{ #category : #'*Containers-Essentials' }
Integer >> nextFromLink: aLink [

	^ aLink nextInteger: self
]

{ #category : #'*Containers-Essentials' }
Integer >> nextOdd [

	"See 'Matters Computational' (ftxbook) section 1.1.9, 
	 Next or previous even or odd value, optimized versions."

	^ self + 1 bitOr: 1
]

{ #category : #'*Containers-Essentials' }
Integer >> nextOddOrSelf [

	"See 'Matters Computational' (ftxbook) section 1.1.9, 
	 Next or previous even or odd value, optimized versions."

	^ self bitOr: 1
]

{ #category : #'*Containers-Essentials' }
Integer >> nthRootsOfUnity [

	^ (0 to: self - 1) collect: [ :j | (2 * Float π * j / self) i exp ]
]

{ #category : #'*Containers-Essentials' }
Integer >> numberOfDigitsInBase2 [

	^ self numberOfDigitsInBase: 2
]

{ #category : #'*Containers-Essentials' }
Integer >> previousEven [

	"See 'Matters Computational' (ftxbook) section 1.1.9, 
	 Next or previous even or odd value, optimized versions."

	^ self - 1 bitAnd: 1 bitInvert
]

{ #category : #'*Containers-Essentials' }
Integer >> previousEvenOrSelf [

	"See 'Matters Computational' (ftxbook) section 1.1.9, 
	 Next or previous even or odd value, optimized versions."

	^ self bitAnd: 1 bitInvert
]

{ #category : #'*Containers-Essentials' }
Integer >> previousOdd [

	"See 'Matters Computational' (ftxbook) section 1.1.9, 
	 Next or previous even or odd value, optimized versions."

	^ (self bitAnd: 1 bitInvert) - 1
]

{ #category : #'*Containers-Essentials' }
Integer >> previousOddOrSelf [

	"See 'Matters Computational' (ftxbook) section 1.1.9, 
	 Next or previous even or odd value, optimized versions."

	^ self - 1 bitOr: 1
]

{ #category : #'*Containers-Essentials' }
Integer >> productTo: upper [

	"Return the product of all integers between 
   the receiver (exclusive) and upper (inclusive)."

	| delta product middle |
	delta := upper subtractNumber: self.
	^ delta <= 0
		  ifTrue: [ Error signal ]
		  ifFalse: [ 
			  delta < 5
				  ifTrue: [ 
					  product := upper.
					  1 to: delta - 1 do: [ :each | 
						  product := (upper subtractNumber: each) multiplyNumber:
							             product ].
					  product ]
				  ifFalse: [ 
					  middle := self + upper >> 1.
					  (self productTo: middle) multiplyNumber:
						  (middle productTo: upper) ] ]
]

{ #category : #'*Containers-Essentials' }
Integer >> quoRemComplementaryInteger: anInteger [

	^ QuoRemComplementary a: anInteger b: self
]

{ #category : #'*Containers-Essentials' }
Integer >> quoRemInteger: anInteger [

	^ QuoRemStandard a: anInteger b: self
]

{ #category : #'*Containers-Essentials' }
Integer >> quoRemMinimalInteger: anInteger [

	^ QuoRemMinimal a: anInteger b: self
]

{ #category : #'*Containers-Essentials' }
Integer >> skewBinaryCanonicalDenseRepresentation [
	^ self isZero
		  ifTrue: [ 0 ~~> nil ]
		  ifFalse: [ 
		  (self skewBinaryCanonicalDenseRepresentationWeight: 1) second ]
]

{ #category : #'*Containers-Essentials' }
Integer >> skewBinaryCanonicalDenseRepresentationWeight: w [
	^ self < w
		  ifTrue: [ Array with: self with: nil ]
		  ifFalse: [ 
			  | rest tuple wDoubled recursiveRepresentation |
			  wDoubled := w * 2.
			  tuple := self skewBinaryCanonicalDenseRepresentationWeight:
				           wDoubled + 1.
			  rest := tuple first.
			  recursiveRepresentation := tuple second.
			  wDoubled = rest
				  ifTrue: [ Array with: 0 with: 2 ~~> recursiveRepresentation ]
				  ifFalse: [ 
					  w <= rest
						  ifTrue: [ 
						  Array with: rest - w with: 1 ~~> recursiveRepresentation ]
						  ifFalse: [ 
						  Array with: rest with: 0 ~~> recursiveRepresentation ] ] ]
]

{ #category : #'*Containers-Essentials' }
Integer >> skewBinaryCanonicalSparseRepresentation [

	^ self isZero
		  ifTrue: [ nil ]
		  ifFalse: [ self asSkewBinaryCanonicalSparse representation ]
]

{ #category : #'*Containers-Essentials' }
Integer >> slowExplicitFibonacci: a tail: b [

	^ (CTRelation is: self greaterThan: 0)
		  slowExplicitFibonacci: a
		  tail: b
		  greaterThanZero: self
]

{ #category : #'*Containers-Essentials' }
Integer >> slowExplicitFibonacci: a tail: b greaterThanZeroIsFalse: aBoolean [

	^ b
]

{ #category : #'*Containers-Essentials' }
Integer >> slowExplicitFibonacci: a tail: b greaterThanZeroIsTrue: aBoolean [

	^ self - 1 slowExplicitFibonacci: (a addNumber: b) tail: a
]

{ #category : #'*Containers-Essentials' }
Integer >> slowFibonacci [

	^ self < 2
		  ifTrue: [ self ]
		  ifFalse: [ 
		  (self - 1) slowFibonacci addNumber: (self - 2) slowFibonacci ]
]

{ #category : #'*Containers-Essentials' }
Integer >> slowFibonacci: a tail: b [

	^ self > 0
		  ifTrue: [ self - 1 slowFibonacci: (a addNumber: b) tail: a ]
		  ifFalse: [ b ]
]

{ #category : #'*Containers-Essentials' }
Integer >> slowFibonacciMemo: aDictionary [

	^ self < 2
		  ifTrue: [ self ]
		  ifFalse: [ 
			  aDictionary at: self ifAbsentPut: [ 
				  (self - 1 slowFibonacciMemo: aDictionary) addNumber:
					  (self - 2 slowFibonacciMemo: aDictionary) ] ]
]
