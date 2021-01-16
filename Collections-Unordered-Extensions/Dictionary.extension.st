Extension { #name : #Dictionary }

{ #category : #'*Collections-Unordered-Extensions' }
Dictionary >> anyAssociation [

	"I mimic the message `Collection>>#anyone` with respect to associations that I collect."

	self
		emptyCheck;
		associationsDo: [ :assoc | ^ assoc ]
]
