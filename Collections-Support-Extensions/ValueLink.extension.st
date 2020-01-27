Extension { #name : #ValueLink }

{ #category : #'*Collections-Support-Extensions' }
ValueLink >> asLinkedList [
	^ LinkedList with: self
]

{ #category : #'*Collections-Support-Extensions' }
ValueLink >> reversed [
	^ self reversed: nil
]

{ #category : #'*Collections-Support-Extensions' }
ValueLink >> reversed: prefix [
	^ nextLink reversed: value ~~> prefix
]

{ #category : #'*Collections-Support-Extensions' }
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
