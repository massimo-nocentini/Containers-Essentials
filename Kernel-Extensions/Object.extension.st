Extension { #name : #Object }

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
