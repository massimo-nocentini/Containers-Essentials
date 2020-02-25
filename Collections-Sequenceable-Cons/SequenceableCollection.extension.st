Extension { #name : #SequenceableCollection }

{ #category : #'*Collections-Sequenceable-Cons' }
SequenceableCollection >> asCons [
	^ Cons fromSequenceableCollection: self
]

{ #category : #'*Collections-Sequenceable-Cons' }
SequenceableCollection >> asConsWithCdr: aCdr [
	^ Cons fromSequenceableCollection: self lastCdr: aCdr
]
