Extension { #name : #SequenceableCollection }

{ #category : #'*Collections-Sequenceable-Extensions' }
SequenceableCollection >> asLinkedList [
	^ self asValueLink asLinkedList
]

{ #category : #'*Collections-Sequenceable-Extensions' }
SequenceableCollection >> asValueLink [
	^ self foldr: #~~> init: nil
]

{ #category : #'*Collections-Sequenceable-Extensions' }
SequenceableCollection >> foldr1: aBlock [ 
	^ self allButLast foldr: aBlock init: self last
]

{ #category : #'*Collections-Sequenceable-Extensions' }
SequenceableCollection >> foldr: aBlock init: init [
	| cell |
	cell := init.
	self reverseDo: [ :each | cell := aBlock value: each value: cell ].
	^ cell
]

{ #category : #'*Collections-Sequenceable-Extensions' }
SequenceableCollection >> halves [
	| middle size |
	size := self size.
	middle := size // 2.
	^ Array
		with: (self copyFrom: 1 to: middle)
		with: (self copyFrom: middle + 1 to: size)
]

{ #category : #'*Collections-Sequenceable-Extensions' }
SequenceableCollection >> halvesAtIncluding: anIndex in: aBlock [

	| prefix suffix |
	prefix := self species new writeStream.
	suffix := self species new writeStream.

	self withIndexDo: [ :each :index | 
		(index <= anIndex
			 ifTrue: [ prefix ]
			 ifFalse: [ suffix ]) nextPut: each ].

	^ aBlock value: prefix contents value: suffix contents
]

{ #category : #'*Collections-Sequenceable-Extensions' }
SequenceableCollection >> scan: aBlock init: aValue [
	^ self class
		new: self size + 1
		streamContents: [ :aStream | 
			| acc |
			acc := aStream nextPut: aValue.
			self do: [ :each | acc := aStream nextPut: acc + each ] ]
]

{ #category : #'*Collections-Sequenceable-Extensions' }
SequenceableCollection >> zip: aSequenceable [
	^ self zip: aSequenceable with: [ :s :o | s -> o ]
]

{ #category : #'*Collections-Sequenceable-Extensions' }
SequenceableCollection >> zip: aSequenceable with: aBlock [

	| l size |
	size := self size min: aSequenceable size.
	l := (1 to: size) collect: [ :_ | nil ] as: self class.
	1 to: size do: [ :i | 
		| v |
		v := aBlock value: (self at: i) value: (aSequenceable at: i).
		l at: i put: v ].
	^ l
]
