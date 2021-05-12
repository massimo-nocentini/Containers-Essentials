Extension { #name : #Dictionary }

{ #category : #'*Containers-Essentials' }
Dictionary >> anyAssociation [

	"I mimic the message `Collection>>#anyone` with respect to associations that I collect."

	self
		emptyCheck;
		associationsDo: [ :assoc | ^ assoc ]
]

{ #category : #'*Containers-Essentials' }
Dictionary >> asKeysAndValuesView [

	^ CTKeysAndValuesView new
		  dictionary: self;
		  yourself
]
