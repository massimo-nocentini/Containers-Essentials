Extension { #name : #SequenceableCollection }

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
SequenceableCollection >> zip: aSequenceable [
	^ self zip: aSequenceable with: [ :s :o | s -> o ]
]

{ #category : #'*Collections-Sequenceable-Extensions' }
SequenceableCollection >> zip: aSequenceable with: aBlock [
	| l |
	l := self class new.
	1 to: (self size min: aSequenceable size) do: [ :i | 
		| v |
		v := aBlock value: (self at: i) value: (aSequenceable at: i).
		l add: v ].
	^ l
]
