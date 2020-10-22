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

{ #category : #'*Kernel-Extensions' }
Object >> asReflexiveAssociation [
	^ self -> self
]

{ #category : #'*Kernel-Extensions' }
Object >> ignoreBlock: aBlock [
	aBlock cull: self.
	^ self
]

{ #category : #'*Kernel-Extensions' }
Object >> recursiveReferences [
	^ {  }
]

{ #category : #'*Kernel-Extensions' }
Object >> |<| aBlockOrSymbol [
	^ [ :arg | 
	  aBlockOrSymbol isSymbol
		  ifTrue: [ self perform: aBlockOrSymbol with: arg ]
		  ifFalse: [ aBlockOrSymbol value: self value: arg ] ]
]

{ #category : #'*Kernel-Extensions' }
Object >> |>| aBlockOrSymbol [
	^ [ :recv | 
	  aBlockOrSymbol isSymbol
		  ifTrue: [ recv perform: aBlockOrSymbol with: self ]
		  ifFalse: [ aBlockOrSymbol value: recv value: self ] ]
]
