Extension { #name : #Behavior }

{ #category : #'*Containers-Essentials' }
Behavior >> kindAsSymbol [

	| code |
	code := self instSpec.
	code = 0 ifTrue: [ ^ '0-sized' asSymbol ].
	code = 1 ifTrue: [ ^ 'non-indexable with ivars' asSymbol ].
	code = 2 ifTrue: [ ^ 'indexable without ivars' asSymbol ].
	code = 3 ifTrue: [ ^ 'indexable with ivars' asSymbol ].
	code = 4 ifTrue: [ ^ 'weak indexable with ivars' asSymbol ].
	code = 5 ifTrue: [ ^ 'weak non-indexable with ivars' asSymbol ].
	code = 7 ifTrue: [ ^ 'immediate' asSymbol ].
	code = 9 ifTrue: [ ^ '64-bit indexable' asSymbol ].
	(code = 10 or: [ code = 11 ]) ifTrue: [ 
		^ '32-bit indexable' asSymbol ].
	(code > 11 and: [ code < 16 ]) ifTrue: [ 
		^ '16-bit indexable' asSymbol ].
	(code > 15 and: [ code < 24 ]) ifTrue: [ 
		^ '8-bit indexable' asSymbol ].
	(code > 23 and: [ code < 32 ]) ifTrue: [ 
		^ 'compiled method' asSymbol ].
	^ #unknown
]

{ #category : #'*Containers-Essentials' }
Behavior >> methodsCount [
	"Answer the number of methods of the receiver that are currently 
	installed in the `methodDictionary`."

	^ self methodDict size
]
