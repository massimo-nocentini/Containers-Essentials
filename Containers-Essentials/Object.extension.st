Extension { #name : #Object }

{ #category : #'*Containers-Essentials' }
Object >> isComplex [
	"Answer true if receiver is a Complex number. False by default."

	^ false

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
