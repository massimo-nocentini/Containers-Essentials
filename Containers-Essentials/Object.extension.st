Extension { #name : #Object }

{ #category : #'*Containers-Essentials' }
Object >> -! aBlock [

	^ aBlock ! self
]

{ #category : #'*Containers-Essentials' }
Object >> asReflexiveAssociation [
	^ self -> self
]

{ #category : #'*Containers-Essentials' }
Object >> asReflexivePoint [

	^ Point x: self y: self
]

{ #category : #'*Containers-Essentials' }
Object >> isComplex [
	"Answer true if receiver is a Complex number. False by default."

	^ false

]

{ #category : #'*Containers-Essentials' }
Object >> prependBlock: aFullBlockClosure [

	^ aFullBlockClosure value: self
]

{ #category : #'*Containers-Essentials' }
Object >> yourself: aBlock [

	"I invoke the given block giving myself as argument if it needs to consume me.
	 Then I return my self discarding the value returned by the given block."

	aBlock cull: self
]

{ #category : #'*Containers-Essentials' }
Object >> |<| aBlockOrSymbol [
	^ [ :arg | 
	  aBlockOrSymbol isSymbol
		  ifTrue: [ self perform: aBlockOrSymbol with: arg ]
		  ifFalse: [ aBlockOrSymbol value: self value: arg ] ]
]

{ #category : #'*Containers-Essentials' }
Object >> |>| aBlockOrSymbol [
	^ [ :recv | 
	  aBlockOrSymbol isSymbol
		  ifTrue: [ recv perform: aBlockOrSymbol with: self ]
		  ifFalse: [ aBlockOrSymbol value: recv value: self ] ]
]
