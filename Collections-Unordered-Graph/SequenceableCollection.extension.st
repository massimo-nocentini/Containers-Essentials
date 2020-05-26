Extension { #name : #SequenceableCollection }

{ #category : #'*Collections-Unordered-Graph' }
SequenceableCollection >> asGraph [
	^ Graph fromSequenceableCollection: self
]
