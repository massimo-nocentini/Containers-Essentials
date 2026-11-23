"
I am a division of two integers, `a = quo·b + rem`, whose quotient is the integer nearest to `a / b`, the upper one if both are as near, so that the absolute value of `rem` is the least. `Integer>>#/%<` makes me.

```smalltalk
(21 /%< 9) asString. ""'21 = 2·9 + 3'""
(25 /%< 9) asString. ""'25 = 3·9 - 2'""
(27 /%< 6) asString ""'27 = 5·6 - 3'""
```

My `asPointWithRespectToRem` answers the coefficients of `a` and `b` in the linear combination that is the absolute value of `rem`.
"
Class {
	#name : 'QuoRemMinimal',
	#superclass : 'QuoRemStandard',
	#category : 'Containers-Essentials-Numbers',
	#package : 'Containers-Essentials',
	#tag : 'Numbers'
}

{ #category : 'converting' }
QuoRemMinimal >> asPointWithRespectToRem [

	| aPoint |
	aPoint := super asPointWithRespectToRem.
	^ self rem ifNegative: [ aPoint negated ] ifNotNegative: [ aPoint ]
]

{ #category : 'accessing' }
QuoRemMinimal >> initialize [

	| floor ceil r |
	super initialize.

	r := self value.

	floor := r floor.
	ceil := r ceiling.

	quo := r - floor < (ceil - r)
		       ifTrue: [ floor ]
		       ifFalse: [ ceil ].

	rem := a - (quo * b)
]
