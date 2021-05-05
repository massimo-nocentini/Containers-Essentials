Extension { #name : #Object }

{ #category : #'*Kernel-Extensions' }
Object >> asReflexiveAssociation [
	^ self -> self
]

{ #category : #'*Kernel-Extensions' }
Object >> asReflexivePoint [

	^ Point x: self y: self
]

{ #category : #'*Kernel-Extensions' }
Object >> isBoolean [

	^ false
]

{ #category : #'*Kernel-Extensions' }
Object >> itself: anObject [

	^ anObject
]

{ #category : #'*Kernel-Extensions' }
Object >> yourself: aBlock [

	"I invoke the given block giving myself as argument if it needs to consume me.
	 Then I return my self discarding the value returned by the given block."

	^ aBlock
		  cull: self;
		  itself: self
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
