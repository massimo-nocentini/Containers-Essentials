Class {
	#name : #SBRAL,
	#superclass : #SkewBinaryCanonicalNumber,
	#category : #'Collections-Sequenceable-SBRAL'
}

{ #category : #accessing }
SBRAL >> add: x [
	| leafBlock |
	leafBlock := [ :sbral | sbral tree: (SBRALBinaryTree leaf: x) ].
	^ self
		incrementIfEmpty: leafBlock
		ifSingleton: leafBlock
		twoInARow: [ :sbral :leftValueLink :rightValueLink | 
			sbral
				tree:
					(SBRALBinaryTree
						node: x
						left: leftValueLink value
						right: rightValueLink value) ]
		otherwise: leafBlock
]

{ #category : #accessing }
SBRAL >> at: i [
	^ self at: i ifAbsent: [ SubscriptOutOfBounds signalFor: i ]
]

{ #category : #accessing }
SBRAL >> at: i association: anAssoc ifPresent: pBlock ifAbsent: aBlock [
	| aTree |
	aTree := anAssoc value.
	^ i = 0
		ifTrue: [ pBlock value: aTree	"Regardless of `anAssoc key`." ]
		ifFalse: [ aTree
				ifLeaf: aBlock
				ifNode: [ :aNode | 
					self
						at: i
						key: anAssoc key
						node: aNode
						ifPresent: pBlock
						ifAbsent: aBlock ] ]
]

{ #category : #accessing }
SBRAL >> at: i ifAbsent: aBlock [
	^ i > 0
		ifTrue: [ self at: i - 1 ifPresent: #content ifAbsent: aBlock ]
		ifFalse: aBlock
]

{ #category : #accessing }
SBRAL >> at: i ifPresent: pBlock ifAbsent: aBlock [
	^ representation
		ifNil: aBlock
		ifNotNil: [ | w |
			w := self key: representation.
			i < w
				ifTrue: [ self
						at: i
						association: representation value
						ifPresent: pBlock
						ifAbsent: aBlock ]
				ifFalse: [ self cdr at: i - w ifPresent: pBlock ifAbsent: aBlock ] ]
]

{ #category : #accessing }
SBRAL >> at: i key: w node: aNode ifPresent: pBlock ifAbsent: aBlock [
	| v |
	v := w // 2.
	^ i <= v
		ifTrue: [ self
				at: i - 1
				association: v -> aNode left
				ifPresent: pBlock
				ifAbsent: aBlock ]
		ifFalse: [ self
				at: i - 1 - v
				association: v -> aNode right
				ifPresent: pBlock
				ifAbsent: aBlock ]
]

{ #category : #accessing }
SBRAL >> head [
	^ representation
		ifNil: [ CollectionIsEmpty signalWith: self ]
		ifNotNil: [ | assoc |
			assoc := representation value.
			assoc value content ]
]

{ #category : #accessing }
SBRAL >> key: aValueLink [
	^ (super key: aValueLink) key
]

{ #category : #accessing }
SBRAL >> tail [
	^ self
		decrementIfOne: #yourself
		otherwise: [ :sbral :assoc | 
			assoc value
				ifLeaf:
					[ self error: 'This block shouldn''t be evaluated, semantic error.' ]
				ifNode: [ :aNode | 
					sbral tree: aNode left.
					sbral cdr tree: aNode right.
					sbral ] ]
]

{ #category : #accessing }
SBRAL >> tree: aTree [
	representation value: representation value -> aTree
]
