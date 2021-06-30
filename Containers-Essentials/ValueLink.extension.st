Extension { #name : #ValueLink }

{ #category : #'*Containers-Essentials' }
ValueLink >> asLinkedList [
	| list |
	list := LinkedList empty.
	self do: [ :each | list addLast: each value ].
	^ list
]

{ #category : #'*Containers-Essentials' }
ValueLink >> do: aBlock [

	^ super do: [ :each | aBlock value: each value ]
]

{ #category : #'*Containers-Essentials' }
ValueLink >> with: aValueLink collect: aBlock [
	^ aValueLink
		ifNil: [ SizeMismatch signal ]
		ifNotNil: [ | links |
			links := nextLink
				ifNotNil: [ nextLink with: aValueLink nextLink collect: aBlock ].
			self class new
				value: (aBlock value: value value: aValueLink value);
				nextLink: links;
				yourself ]
]
