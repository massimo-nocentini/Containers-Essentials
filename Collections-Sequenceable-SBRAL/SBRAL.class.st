Class {
	#name : #SBRAL,
	#superclass : #SkewBinaryCanonicalNumber,
	#instVars : [
		'insertingObject'
	],
	#category : #'Collections-Sequenceable-SBRAL'
}

{ #category : #API }
SBRAL >> add: x [
	insertingObject := Maybe just: x.
	^ self increment
]

{ #category : #API }
SBRAL >> allButFirst [
	^ self decrement
]

{ #category : #API }
SBRAL >> at: i [
	^ self at: i ifAbsent: [ SubscriptOutOfBounds signalFor: i ]
]

{ #category : #private }
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

{ #category : #API }
SBRAL >> at: i ifAbsent: aBlock [
	^ i > 0
		ifTrue: [ self at: i - 1 ifPresent: #content ifAbsent: aBlock ]
		ifFalse: aBlock
]

{ #category : #private }
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

{ #category : #private }
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

{ #category : #API }
SBRAL >> at: i put: y [
	| aBlock |
	aBlock := [ SubscriptOutOfBounds signalFor: i ].
	^ i > 0
		ifTrue: [ self at: i - 1 put: y ifAbsent: aBlock ]
		ifFalse: aBlock
]

{ #category : #private }
SBRAL >> at: i put: y association: assoc ifAbsent: aBlock [
	| aTree |
	aTree := assoc value.
	^ i = 0
		ifTrue: [ aTree
				ifLeaf: [ :aLeaf | SBRALBinaryTree leaf: y	"Discard the provided one." ]
				ifNode:
					[ :aNode | SBRALBinaryTree node: y left: aNode left right: aNode right ] ]
		ifFalse: [ aTree
				ifLeaf: aBlock
				ifNode: [ :aNode | 
					self
						at: i
						put: y
						key: assoc key
						node: aNode
						ifAbsent: aBlock ] ]
]

{ #category : #private }
SBRAL >> at: i put: y ifAbsent: aBlock [
	^ representation
		ifNil: aBlock
		ifNotNil: [ | w assoc |
			assoc := representation value.
			w := assoc key.
			i < w
				ifTrue: [ | aTree |
					aTree := self
						at: i
						put: y
						association: assoc
						ifAbsent: aBlock.
					self cdr cons: w -> aTree ]
				ifFalse: [ (self cdr at: i - w put: y ifAbsent: aBlock) cons: assoc ] ]
]

{ #category : #private }
SBRAL >> at: i put: y key: w node: aNode ifAbsent: aBlock [
	| v |
	v := w // 2.
	^ i <= v
		ifTrue: [ SBRALBinaryTree
				node: aNode content
				left:
					(self
						at: i - 1
						put: y
						association: v -> aNode left
						ifAbsent: aBlock)
				right: aNode right ]
		ifFalse: [ SBRALBinaryTree
				node: aNode content
				left: aNode left
				right:
					(self
						at: i - 1 - v
						put: y
						association: v -> aNode right
						ifAbsent: aBlock) ]
]

{ #category : #API }
SBRAL >> decremented: sbral bitZeroOrTwo: assoc [
	^ assoc value
		ifLeaf: [ self error: 'This block shouldn''t be evaluated, semantic error.' ]
		ifNode: [ :aNode | 
			sbral tree: aNode left.
			sbral cdr tree: aNode right.
			sbral ]
]

{ #category : #API }
SBRAL >> first [
	^ representation
		ifNil: [ CollectionIsEmpty signalWith: self ]
		ifNotNil: [ | assoc |
			assoc := representation value.
			assoc value content ]
]

{ #category : #API }
SBRAL >> incremented: sbral [
	^ sbral tree: (SBRALBinaryTree leaf: insertingObject content)
]

{ #category : #API }
SBRAL >> incremented: sbral two: leftValueLink inARow: rightValueLink [
	^ sbral
		tree:
			(SBRALBinaryTree
				node: insertingObject content
				left: leftValueLink value
				right: rightValueLink value)
]

{ #category : #API }
SBRAL >> incrementedDifferentBits: sbral [
	^ self incremented: sbral
]

{ #category : #API }
SBRAL >> incrementedSingleton: sbral [
	^ self incremented: sbral
]

{ #category : #API }
SBRAL >> incrementedZero: sbral [
	^ self incremented: sbral
]

{ #category : #API }
SBRAL >> initialize [
	insertingObject := Maybe nothing
]

{ #category : #accessing }
SBRAL >> key: aValueLink [
	^ (super key: aValueLink) key
]

{ #category : #accessing }
SBRAL >> tree: aTree [
	representation value: representation value -> aTree
]
