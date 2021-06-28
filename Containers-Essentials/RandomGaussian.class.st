"
Uses Kinderman and Monahan method. Reference: Kinderman, A.J. and Monahan, J.F., 
""""Computer generation of random variables using the ratio of uniform deviates"""", 
ACM Trans Math Software, 3, (1977), pp257-260.
"
Class {
	#name : #RandomGaussian,
	#superclass : #Random,
	#instVars : [
		'mu',
		'sigma',
		'densityMultiplier'
	],
	#category : #'Containers-Essentials-Random'
}

{ #category : #'*Containers-Essentials' }
RandomGaussian >> densityOfNumber: x [

	^ densityMultiplier * ((x - mu / sigma) squared negated / 2) exp
]

{ #category : #initialization }
RandomGaussian >> initialize [

	super initialize.

	self
		mu: 0;
		sigma: 1
]

{ #category : #accessing }
RandomGaussian >> mu: anObject [

	mu := anObject
]

{ #category : #accessing }
RandomGaussian >> next [

	"Python implementation:

	.. code:: 
		
        random = self.random
        while 1:
            u1 = random()
            u2 = 1.0 - random()
            z = NV_MAGICCONST*(u1-0.5)/u2
            zz = z*z/4.0
            if zz <= -_log(u2):
                break
        return mu + z*sigma"

	| z magic |
	magic := -0.5 exp * 4 / 2 sqrt.

	[ 
	| u1 u2 |
	u1 := super next.
	u2 := 1.0 - super next.

	z := u1 - 0.5 * magic / u2.

	(z / 2) squared > u2 log negated ] whileTrue.

	^ z * sigma + mu
]

{ #category : #accessing }
RandomGaussian >> sigma: anObject [

	sigma := anObject.

	densityMultiplier := (Float twoPi sqrt * sigma) reciprocal
]
