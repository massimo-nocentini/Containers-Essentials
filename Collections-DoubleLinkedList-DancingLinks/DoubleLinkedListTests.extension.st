Extension { #name : #DoubleLinkedListTests }

{ #category : #'*Collections-DoubleLinkedList-DancingLinks' }
DoubleLinkedListTests >> testDancingLinksCreateFirstKnuthMatrix [
	| matrix |
	matrix := Array2D
		rows: 6
		columns: 7
		onesAt:
			{(1 @ 3).
			(1 @ 5).
			(1 @ 6).
			(2 @ 1).
			(2 @ 4).
			(2 @ 7).
			(3 @ 2).
			(3 @ 3).
			(3 @ 6).
			(4 @ 1).
			(4 @ 4).
			(5 @ 2).
			(5 @ 7).
			(6 @ 4).
			(6 @ 5).
			(6 @ 7)}. self assert: matrix printString equals: '(0 0 1 0 1 1 0
1 0 0 1 0 0 1
0 1 1 0 0 1 0
1 0 0 1 0 0 0
0 1 0 0 0 0 1
0 0 0 1 1 0 1 )'
]

{ #category : #'*Collections-DoubleLinkedList-DancingLinks' }
DoubleLinkedListTests >> testMakeCircular [
	| list linkOne linkTwo |
	list := DoubleLinkedList new.
	linkOne := list add: 1.
	linkTwo := list add: 2.
	list makeCircular.
	self assert: list first equals: 1.
	self assert: list last equals: 2.
	linkOne remove.
	self assert: list first equals: 2.
	self assert: list last equals: 2.
	"self assert: list asArray equals: #(1 2).
	linkTwo remove.
	self assert: list first equals: 1.
	self assert: list last equals: 2.
	self assert: list asArray equals: #(1 2).
	list := DoubleLinkedList new.
	linkOne := list add: 1.
	linkOne remove.
	self assert: list first equals: 1.
	self assert: list last equals: 1.
	self assert: list asArray equals: #(1).
	list := DoubleLinkedList new.
	linkOne := list add: 1.
	linkTwo := list add: 2.
	linkOne remove.
	linkTwo remove.
	self assert: list first equals: 1.
	self assert: list last equals: 2.
	self assert: list asArray equals: #(1 2)"
]

{ #category : #'*Collections-DoubleLinkedList-DancingLinks' }
DoubleLinkedListTests >> testRemoveUsingPreviousAndNextLinks [
	| list link |
	list := DoubleLinkedList new.
	list add: 1.
	link := list add: 2.
	list add: 3.
	link remove.
	self assert: list first equals: 1.
	self assert: list last equals: 3.
	self assert: list asArray equals: #(1 3)
]

{ #category : #'*Collections-DoubleLinkedList-DancingLinks' }
DoubleLinkedListTests >> testRemoveUsingPreviousAndNextLinksBoundaryCases [
	| list linkOne linkTwo |
	list := DoubleLinkedList new.
	linkOne := list add: 1.
	linkTwo := list add: 2.
	linkOne remove.
	self assert: list first equals: 1.
	self assert: list last equals: 2.
	self assert: list asArray equals: #(1 2).
	linkTwo remove.
	self assert: list first equals: 1.
	self assert: list last equals: 2.
	self assert: list asArray equals: #(1 2).
	list := DoubleLinkedList new.
	linkOne := list add: 1.
	linkOne remove.
	self assert: list first equals: 1.
	self assert: list last equals: 1.
	self assert: list asArray equals: #(1).
	list := DoubleLinkedList new.
	linkOne := list add: 1.
	linkTwo := list add: 2.
	linkOne remove.
	linkTwo remove.
	self assert: list first equals: 1.
	self assert: list last equals: 2.
	self assert: list asArray equals: #(1 2).
]

{ #category : #'*Collections-DoubleLinkedList-DancingLinks' }
DoubleLinkedListTests >> testRestoreUsingPreviousAndNextLinks [
	| list link |
	list := DoubleLinkedList new.
	list add: 1.
	link := list add: 2.
	list add: 3.
	link remove restore.
	self
		assert: list asArray
		equals: #(1 2 3). link restore restore restore.
	self assert: list asArray equals: #(1 2 3)
]
