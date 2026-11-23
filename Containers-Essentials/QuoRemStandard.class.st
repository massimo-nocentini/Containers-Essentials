"
I am a division of two integers, `a = quo·b + rem`, whose quotient is rounded down: `quo` is the floor of `a / b`. `Integer>>#/%` makes me.

```smalltalk
(21 /% 9) asString. ""'21 = 2·9 + 3'""
(21 /% 9) complement asString ""'21 = 3·9 - 6'""
```

`complement` answers the division of the same integers whose quotient is rounded up. My `asPointWithRespectToRem` answers the coefficients of `a` and `b` in the linear combination that is `rem`.
"
Class {
	#name : 'QuoRemStandard',
	#superclass : 'QuoRemComplementary',
	#category : 'Containers-Essentials-Numbers',
	#package : 'Containers-Essentials',
	#tag : 'Numbers'
}

{ #category : 'converting' }
QuoRemStandard >> asPointWithRespectToRem [

	^ super asPointWithRespectToRem negated
]

{ #category : 'converting' }
QuoRemStandard >> complement [

	^ QuoRemComplementary a: a b: b
]

{ #category : 'accessing' }
QuoRemStandard >> initialize [

	super initialize.

	quo := self value floor.
	rem := a - (quo * b)
]

{ #category : 'converting' }
QuoRemStandard >> numberOfDots [

	| absRem |
	absRem := rem ifPositive: #yourself ifNotPositive: [ 0 ].

	^ super numberOfDots + absRem
]
