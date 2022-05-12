Extension { #name : #Float }

{ #category : #'*Containers-Essentials' }
Float >> arcCosh [
	"Answer receiver's area hyperbolic cosine.
	That is the inverse function of cosh."

	self < 1 
		ifTrue: 
			[^DomainError signal: 'Receiver must be greater or equal to 1'].
	^self + 1 = self 
		ifTrue: [self abs ln + 2 ln]
		ifFalse: [((self squared - 1) sqrt + self) ln]
]

{ #category : #'*Containers-Essentials' }
Float >> arcSinh [
	"Answer receiver's area hyperbolic sine.
	That is the inverse function of sinh."

	self = 0.0 ifTrue: [^self].	"Handle negativeZero"  
	^self + 1 = self 
		ifTrue: [(self abs ln + 2 ln) * self sign]
		ifFalse: [((self squared + 1) sqrt + self) ln]
]

{ #category : #'*Containers-Essentials' }
Float >> arcTanh [

	"Answer receiver's area hyperbolic tangent.
	That is the inverse function of tanh."

	self = 0.0 ifTrue: [ ^ self ]. "Handle negativeZero"
	self abs = 1 ifTrue: [ ^ self copySignTo: Float infinity ].
	self abs > 1 ifTrue: [ 
		^ DomainError signal: 'Receiver must be between -1.0 and 1.0' ].
	^ (1 + self / (1 - self)) ln / 2
]

{ #category : #'*Containers-Essentials' }
Float class >> bronzeRatio [

	^ 1.0 - self silverRatio
]

{ #category : #'*Containers-Essentials' }
Float >> cosh [
	"Answer receivers hyperbolic cosine."
	
	| ex |
	ex := self abs exp.
	^(ex + ex reciprocal) / 2
]

{ #category : #'*Containers-Essentials' }
Float >> double [

	^ self * 2.0
]

{ #category : #'*Containers-Essentials' }
Float class >> goldenPlatinumRatio [

	^ self goldenRatio + self platinumRatio
]

{ #category : #'*Containers-Essentials' }
Float >> halved [

	^ self * 0.5
]

{ #category : #'*Containers-Essentials' }
Float >> sinh [
	"Answer receivers hyperbolic sine"
	
	| ex |
	ex := self abs exp.
	^self copySignTo: (ex - ex reciprocal) / 2
]

{ #category : #'*Containers-Essentials' }
Float >> tanh [
	"Answer hyperbolic tangent of receiver.
	Trivial implementation is:
		^self sinh/self cosh
	This implementation takes care not to overflow."

	| ex emx |
	self = 0.0 ifTrue: [^self].	"Handle negativeZero"
	self > 20.0 ifTrue: [^1.0].
	self < -20.0 ifTrue: [^-1.0].
	ex := self exp.
	emx := ex reciprocal.
	^(ex - emx) / (ex + emx)
]
