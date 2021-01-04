Extension { #name : #ValueLink }

{ #category : #'*Collections-Support-Extensions' }
ValueLink >> asLinkedList [
	| list |
	list := LinkedList empty.
	self do: [ :each | list addLast: each value ].
	^ list
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
ValueLink >> size [

	| size nl |
	size := 1.
	nl := self.
	[ nl := nl nextLink ] whileNotNil: [ size := size + 1 ].
	^ size
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
