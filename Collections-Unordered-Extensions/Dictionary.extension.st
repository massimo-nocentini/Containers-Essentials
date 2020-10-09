Extension { #name : #Dictionary }

{ #category : #'*Collections-Unordered-Extensions' }
Dictionary >> anyAssociation [
	self associationsDo: [ :assoc | ^ assoc ]
]
