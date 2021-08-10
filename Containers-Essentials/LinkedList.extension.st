Extension { #name : #LinkedList }

{ #category : #'*Containers-Essentials' }
LinkedList >> , other [
	"Optimized version of append for this specific linked container"

	^ other
		ifEmpty: [ self ]
		ifNotEmpty: [ self
				addLast: other firstLink;
				yourself ]
]

{ #category : #'*Containers-Essentials' }
LinkedList >> allButFirst [
	^ self cdr
]

{ #category : #'*Containers-Essentials' }
LinkedList >> car [
	"Return the very first element"

	^ self first
]

{ #category : #'*Containers-Essentials' }
LinkedList >> cdr [
	"Returns the tail of this list"

	^ self
		ifNotEmpty: [ firstLink nextLink
				ifNil: [ self class new ]
				ifNotNil: [ :nl | self class with: nl ] ]
]
