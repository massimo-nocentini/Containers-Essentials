Extension { #name : #SequenceableCollection }

{ #category : #'*Collections-Unordered-Graph' }
SequenceableCollection >> asGraph [
	^ Graph fromSequenceableCollection: self
]

{ #category : #'*Collections-Unordered-Graph' }
SequenceableCollection >> asTree [
	^ Tree fromSequenceableCollection: self
]
