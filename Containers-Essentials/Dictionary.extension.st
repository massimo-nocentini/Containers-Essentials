Extension { #name : #Dictionary }

{ #category : #'*Containers-Essentials' }
Dictionary >> anyAssociation [

	"I mimic the message `Collection>>#anyone` with respect to associations that I collect."

	self
		emptyCheck;
		associationsDo: [ :assoc | ^ assoc ]
]

{ #category : #'*Containers-Essentials' }
Dictionary >> inverted [

	^ self invertedIfCollision: [ :v :collision | 
		  Array streamContents: [ :aStream | collision flattenOn: aStream ] ]
]

{ #category : #'*Containers-Essentials' }
Dictionary >> invertedIfCollision: aBlock [

	| invert |
	invert := self class new.

	self keysAndValuesDo: [ :k :v | 
		| resolved |
		resolved := invert
			            at: v
			            ifPresent: [ :p | 
			            aBlock value: v value: (Array with: p with: k) ]
			            ifAbsent: [ k ].
		invert at: v put: resolved ].

	^ invert
]
