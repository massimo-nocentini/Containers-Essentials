Class {
	#name : #ComplexTest,
	#superclass : #TestCase,
	#category : #'Containers-Essentials-Tests-Tests'
}

{ #category : #tests }
ComplexTest >> testAbs [
	"self run: #testAbs"
	"self debug: #testAbs"
	
	| c |
	c := (6 - 6 i).
	self assert: c abs  = 72 sqrt.
	
]

{ #category : #tests }
ComplexTest >> testAdding [
	"self run: #testAdding"
	
	| c |
	c := (5 - 6 i) + (-5 + 8 i).     "Complex with Complex"
	self assert: (c =  (0 + 2 i)).
]

{ #category : #tests }
ComplexTest >> testArcCos [
	| c |
	c := (0.5 + 0 i).
	self assert: (c arcCos real closeTo: c real arcCos).
	self assert: (c arcCos imaginary closeTo: 0).
	#(-0.5 -2 -3 0 0.5 2 3) do: [:real |
	#(-0.5 -2 -3 0 0.5 2 3) do: [:imag |
		c := real + imag i.
		self assert: (c arcCos cos real closeTo: c real).
		self assert: (c arcCos cos imaginary closeTo: c imaginary)]]
]

{ #category : #tests }
ComplexTest >> testArcCosPlusArcSin [
	| c |
	#(-0.5 -2 -3 0 0.5 2 3) do: [:real |
	#(-0.5 -2 -3 0 0.5 2 3) do: [:imag |
		c := real + imag i.
		self assert: ((c arcCos + c arcSin) real closeTo: Float halfPi).
		self assert: ((c arcCos + c arcSin) imaginary closeTo: 0.0)]]
]

{ #category : #tests }
ComplexTest >> testArcCosh [
	| c |
	c := (2.5 + 0 i).
	self assert: (c arcCosh real closeTo: c real arcCosh).
	self assert: (c arcCosh imaginary closeTo: 0).
	#(-0.5 -2 -3 0 0.5 2 3) do: [:real |
	#(-0.5 -2 -3 0 0.5 2 3) do: [:imag |
		c := real + imag i.
		self assert: (c arcCosh cosh real closeTo: c real).
		self assert: (c arcCosh cosh imaginary closeTo: c imaginary).
		self deny: c arcCosh real negative]]
]

{ #category : #tests }
ComplexTest >> testArcSin [
	| c |
	c := (0.5 + 0 i).
	self assert: (c arcSin real closeTo: c real arcSin).
	self assert: (c arcSin imaginary closeTo: 0).
	#(-0.5 -2 -3 0 0.5 2 3) do: [:real |
	#(-0.5 -2 -3 0 0.5 2 3) do: [:imag |
		c := real + imag i.
		self assert: (c arcSin sin real closeTo: c real).
		self assert: (c arcSin sin imaginary closeTo: c imaginary)]]
]

{ #category : #tests }
ComplexTest >> testArcSinh [
	| c |
	c := (2.5 + 0 i).
	self assert: (c arcSinh real closeTo: c real arcSinh).
	self assert: (c arcSinh imaginary closeTo: 0).
	#(-0.5 -2 -3 0 0.5 2 3) do: [:real |
	#(-0.5 -2 -3 0 0.5 2 3) do: [:imag |
		c := real + imag i.
		self assert: (c arcSinh sinh real closeTo: c real).
		self assert: (c arcSinh sinh imaginary closeTo: c imaginary)]]
]

{ #category : #tests }
ComplexTest >> testArcTan [
	| c |
	c := (0.5 + 0 i).
	self assert: (c arcTan real closeTo: c real arcTan).
	self assert: (c arcTan imaginary closeTo: 0).
	#(-0.5 -2 -3 0 0.5 2 3) do: [:real |
	#(-0.5 -2 -3 0 0.5 2 3) do: [:imag |
		c := real + imag i.
		self assert: (c arcTan tan real closeTo: c real).
		self assert: (c arcTan tan imaginary closeTo: c imaginary)]]
]

{ #category : #tests }
ComplexTest >> testArcTanh [
	| c |
	c := (0.5 + 0 i).
	self assert: (c arcTanh real closeTo: c real arcTanh).
	self assert: (c arcTanh imaginary closeTo: 0).
	#(-0.5 -2 -3 0 0.5 2 3) do: [:real |
	#(-0.5 -2 -3 0 0.5 2 3) do: [:imag |
		c := real + imag i.
		self assert: (c arcTanh tanh real closeTo: c real).
		self assert: (c arcTanh tanh imaginary closeTo: c imaginary)]]
]

{ #category : #tests }
ComplexTest >> testArg [
	"self run: #testArg"
	"self debug: #testArg"
	
	| c |
	c := (0 + 5 i) .
	self assert: c arg  = (Float pi/ 2).
	
]

{ #category : #'tests - bugs' }
ComplexTest >> testBug1 [

	self assert: (0.5 * (2+0i) ln) exp = (0.5 * 2 ln) exp.
]

{ #category : #tests }
ComplexTest >> testComplexCollection [
	"self run: #testComplexCollection"
	"self debug: #testComplexCollection"
	
	| array array2 |
	array := Array with: 1 + 2i with:  3 + 4i with: 5 + 6i.
	array2 := 2 * array.
	array with:  array2 do: [:one :two | self assert: (2 * one) = two ] 
]

{ #category : #tests }
ComplexTest >> testConjugated [
	
	| c cc |
	c := (5 - 6 i).
	cc := c conjugated.
	self assert: cc real = c real.
	self assert: cc imaginary = c imaginary negated.
]

{ #category : #tests }
ComplexTest >> testConversion [
	"self run: #testConversion"
	"self debug: #testConversion"
	
	self assert: ((1 + 2i) + 1) =  (2 + 2 i).
	self assert: (1 + (1 + 2i)) =  (2 + 2 i).
	self assert: ((1 + 2i) + 1.0) =  (2.0 + 2 i).
	self assert: (1.0 + (1 + 2i)) =  (2.0 + 2 i).
	self assert: ((1 + 2i) + (2/3)) = ((5/3) + 2 i ).
	self assert: ((2/3) + (1 + 2i)) = ((5/3) + 2 i )
]

{ #category : #tests }
ComplexTest >> testCos [
	| c c2 |
	c := (2 + 0 i).
	self assert: (c cos real closeTo: c real cos).
	self assert: (c cos imaginary closeTo: 0).
	c := (2 + 3 i).
	c2 := c i exp + c i negated exp / 2.
	self assert: (c cos real closeTo: c2 real).
	self assert: (c cos imaginary closeTo: c2 imaginary).
]

{ #category : #tests }
ComplexTest >> testCos2PlusSin2 [
	| c |
	#(-0.5 -2 -3 0 0.5 2 3) do: [:real |
	#(-0.5 -2 -3 0 0.5 2 3) do: [:imag |
		c := real + imag i.
		self assert: ((c cos squared + c sin squared) real closeTo: 1).
		self assert: ((c cos squared + c sin squared) imaginary closeTo: 0.0)]]
]

{ #category : #tests }
ComplexTest >> testCosh [
	| c c2 |
	c := (2 + 0 i).
	self assert: (c cosh real closeTo: c real cosh).
	self assert: (c cosh imaginary closeTo: 0).
	c := (2 + 3 i).
	c2 := c exp + c negated exp / 2.
	self assert: (c cosh real closeTo: c2 real).
	self assert: (c cosh imaginary closeTo: c2 imaginary).
	c2 := c i cos.
	self assert: (c cosh real closeTo: c2 real).
	self assert: (c cosh imaginary closeTo: c2 imaginary).
]

{ #category : #tests }
ComplexTest >> testCosh2MinusSinh2 [
	| c |
	#(-0.5 -2 -3 0 0.5 2 3) do: [:real |
	#(-0.5 -2 -3 0 0.5 2 3) do: [:imag |
		c := real + imag i.
		self assert: ((c cosh squared - c sinh squared) real closeTo: 1).
		self assert: ((c cosh squared - c sinh squared) imaginary closeTo: 0.0)]]
]

{ #category : #tests }
ComplexTest >> testCreation [
	"self run: #testCreation"
	
	| c |
	c := 5 i.
	self assert: (c real = 0).
	self assert: (c imaginary = 5).
	
	c := 6 + 7 i.
	self assert: (c real = 6).
	self assert: ( c imaginary = 7).
	
	c := 5.6 - 8 i.
	self assert: (c real = 5.6).
	self assert: (c imaginary = -8).
	
	c := Complex real: 10 imaginary: 5.
	self assert: (c real = 10).
	self assert: (c imaginary = 5).
	
	c := Complex abs: 5 arg: (Float pi/2).
	self assert: (c real rounded = 0).
	self assert: (c imaginary = 5).
	
]

{ #category : #tests }
ComplexTest >> testDivision1 [
	"self run: #testDivision1"
	"self debug: #testDivision1"
	
	| c1 c2 quotient |
	c1 := 2.0e252 + 3.0e70 i.
	c2 := c1.
	quotient := c1 / c2.
 	self deny: (quotient - 1) isZero.
	
	"This test fails due to the wonders of floating point arithmetic. 
	 Please have a look at Complex>>divideSecureBy: and #divideFastAndSecureBy:
	how this can be avoided."
	

]

{ #category : #tests }
ComplexTest >> testEquality [
	"self run: #testEquality"
	"self debug: #testEquality"
	
	self assert: 0i = 0.
	self assert: (2 - 5i) = ((1 -4 i) + (1 - 1i)).
	self assert: 0i isZero.
	self deny: (1 + 3 i) = 1.
	self deny: (1 + 3 i) = (1 + 2i).

"Some more stuff"
	self deny: (1 i) = nil.
	self deny: nil = (1 i).

	self deny: (1 i) = #(1 2 3).
	self deny: #(1 2 3) = (1 i).

	self deny: (1 i) = 0.
	self deny: 0 = (1 i).

	self assert:  (1 + 0 i) = 1.
	self assert:  1 = (1+ 0 i).

	self assert:  (1 + 0 i) = 1.0.
	self assert:  1.0 = (1+ 0 i).

	self assert:  (1/2 + 0 i) = (1/2).
	self assert:  (1/2) = (1/2+ 0 i).
]

{ #category : #tests }
ComplexTest >> testIsquared [

	self assert: 1 i squared equals: -1
]

{ #category : #tests }
ComplexTest >> testLn [
	self assert: (Float e + 0 i) ln = Float e ln "See Bug 1815 on Mantis"
]

{ #category : #tests }
ComplexTest >> testMultiplyByI [
	
	| c |
	c := (5 - 6 i).
	self assert: (c * 1i = c i)
]

{ #category : #tests }
ComplexTest >> testNegated [
	"self run: #testNegated"
	"self debug: #testNegated"
	
	| c |
	c := (2 + 5 i) .
	self assert: c negated  = (-2 - 5i).
	
]

{ #category : #tests }
ComplexTest >> testPolarForm [

	1 + 1 i polarForm: [ :r :theta |
		self
			assert: r equals: 2 sqrt;
			assert: theta equals: Float π / 4 ].

	1 + 2 i polarForm: [ :r :theta |
		self
			assert: r equals: 5 sqrt;
			assert: theta equals: 1.1071487177940904 ]
]

{ #category : #tests }
ComplexTest >> testRaisedTo [
	
	| c c3 |
	c := (5 - 6 i).
	c3 := (c raisedTo: 0.2) raisedTo: 5.
	self assert: (c3 real closeTo: c real).
	self assert: (c3 imaginary closeTo: c imaginary).
]

{ #category : #tests }
ComplexTest >> testRaisedToInteger [
	
	| c c3 |
	c := (5 - 6 i).
	c3 := (c * c * c).
	self assert: (c3 = (c raisedToInteger: 3)).
	self assert: (c3 reciprocal = (c raisedToInteger: -3)).
]

{ #category : #tests }
ComplexTest >> testReciprocal [
	"self run: #testReciprocal"
	"self debug: #testReciprocal"
	
	| c |
	c := (2 + 5 i).
	self assert: c reciprocal  = ((2/29) - (5/29)i).
	
]

{ #category : #tests }
ComplexTest >> testReciprocalError [
	"self run: #testReciprocalError"
	"self debug: #testReciprocalError"
	
	| c |
	c := (0 i).
	self should: [c reciprocal] raise: ZeroDivide
	
]

{ #category : #tests }
ComplexTest >> testSecureDivision1 [
	"self run: #testSecureDivision1"
	"self debug: #testSecureDivision1"
	
	| c1 c2 quotient |
	c1 := 2.0e252 + 3.0e70 i.
	c2 := c1.
	quotient := c1 divideSecureBy: c2.
	self assert: (quotient - 1) isZero.
	
]

{ #category : #tests }
ComplexTest >> testSecureDivision2 [
	"self run: #testSecureDivision2"
	"self debug: #testSecureDivision2"
	
	| c1 c2 quotient |
 	c1 := 2.0e252 + 3.0e70 i.
 	c2 := c1.
 	quotient := c1 divideFastAndSecureBy: c2.
	self assert: (quotient - 1) isZero.
	
]

{ #category : #tests }
ComplexTest >> testSin [
	| c c2 |
	c := (2 + 0 i).
	self assert: (c sin real closeTo: c real sin).
	self assert: (c sin imaginary closeTo: 0).
	c := 2 + 3 i.
	c2 := c i exp - c i negated exp / 2 i.
	self assert: (c sin real closeTo: c2 real).
	self assert: (c sin imaginary closeTo: c2 imaginary).
]

{ #category : #tests }
ComplexTest >> testSinh [
	| c c2 |
	c := (2 + 0 i).
	self assert: (c sinh real closeTo: c real sinh).
	self assert: (c sinh imaginary closeTo: 0).
	c := 2 + 3 i.
	c := c cosh squared - c sinh squared.
	self assert: (c real closeTo: 1).
	self assert: (c imaginary closeTo: 0).
	c2 := c exp - c negated exp / 2.
	self assert: (c sinh real closeTo: c2 real).
	self assert: (c sinh imaginary closeTo: c2 imaginary).
	c2 := c i sin i negated.
	self assert: (c sinh real closeTo: c2 real).
	self assert: (c sinh imaginary closeTo: c2 imaginary).
]

{ #category : #tests }
ComplexTest >> testSquared [
	"self run: #testSquared"
	"self debug: #testSquared"
	
	| c c2 |
	c := (6 - 6 i).
	c2 := (c squared).
	self assert: c2 imaginary = -72.
	self assert: c2 real = 0.
]

{ #category : #tests }
ComplexTest >> testTan [
	| c c2 |
	c := (2 + 0 i).
	self assert: (c tan real closeTo: c real tan).
	self assert: (c tan imaginary closeTo: 0).
	c := 2 + 3 i.
	c2 := c sin / c cos.
	self assert: (c2 real closeTo: c tan real).
	self assert: (c2 imaginary closeTo: c tan imaginary).
]

{ #category : #tests }
ComplexTest >> testTanh [
	| c c2 |
	c := (2 + 0 i).
	self assert: (c tanh real closeTo: c real tanh).
	self assert: (c tanh imaginary closeTo: 0).
	c := 2 + 3 i.
	c2 := c sinh / c cosh.
	self assert: (c2 real closeTo: c tanh real).
	self assert: (c2 imaginary closeTo: c tanh imaginary).
]
