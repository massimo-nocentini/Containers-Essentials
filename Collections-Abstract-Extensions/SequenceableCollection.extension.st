Extension { #name : #SequenceableCollection }

{ #category : #'*Collections-Abstract-Extensions' }
SequenceableCollection >> asLinkedList [
	^ self asValueLink asLinkedList
]

{ #category : #'*Collections-Abstract-Extensions' }
SequenceableCollection >> asValueLink [

	^ self
		  foldr: [ :each :aValueLink | 
			  ValueLink new
				  value: each;
				  nextLink: aValueLink;
				  yourself ]
		  init: nil
]

{ #category : #'*Collections-Abstract-Extensions' }
SequenceableCollection >> foldr1: aBlock [

	| folded |
	folded := self last.

	self size - 1 to: 1 by: -1 do: [ :index | 
	folded := aBlock value: (self at: index) value: folded ].

	^ folded
]

{ #category : #'*Collections-Abstract-Extensions' }
SequenceableCollection >> foldr: aBlock init: init [
	| cell |
	cell := init.
	self reverseDo: [ :each | cell := aBlock value: each value: cell ].
	^ cell
]

{ #category : #'*Collections-Abstract-Extensions' }
SequenceableCollection >> halves [

	^ self
		  halvesAtIncluding: self size // 2
		  in: [ :prefix :suffix | Array with: prefix with: suffix ]
]

{ #category : #'*Collections-Abstract-Extensions' }
SequenceableCollection >> halvesAtIncluding: anIndex in: aBlock [

	| prefix suffix |
	prefix := self class streamContents: [ :aStream | 
		          1 to: anIndex do: [ :index | 
		          aStream nextPut: (self at: index) ] ].
	suffix := self class streamContents: [ :aStream | 
		          anIndex + 1 to: self size do: [ :index | 
		          aStream nextPut: (self at: index) ] ].

	^ aBlock value: prefix contents value: suffix contents
]

{ #category : #'*Collections-Abstract-Extensions' }
SequenceableCollection >> scan: aBlock init: aValue [

	^ self class new: self size + 1 streamContents: [ :aStream | 
		  | acc |
		  acc := aStream nextPut: aValue.
		  self do: [ :each | 
			  acc := aBlock value: acc value: each.
			  aStream nextPut: acc ] ]
]

{ #category : #'*Collections-Abstract-Extensions' }
SequenceableCollection >> zip: aSequenceable [
	^ self zip: aSequenceable with: [ :s :o | s -> o ]
]

{ #category : #'*Collections-Abstract-Extensions' }
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
