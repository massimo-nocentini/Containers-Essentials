Extension { #name : #Object }

{ #category : #'*Kernel-Extensions' }
Object >> I [
]

{ #category : #'*Kernel-Extensions' }
Object >> K [
	^ [ :_ | self ]
]

{ #category : #'*Kernel-Extensions' }
Object >> S: x [
	

	^ [ :y | self S: x s: y ]
]

{ #category : #'*Kernel-Extensions' }
Object >> S: x s: y [
	"x y z = (x z) (y z)"

	| X |
	X := x value: self.
	^ X value: (y value: self)
]
