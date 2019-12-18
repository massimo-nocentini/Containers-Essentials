Extension { #name : #SequenceableCollection }

{ #category : #'*Collections-Sequenceable-Sorting' }
SequenceableCollection >> scan: aBlock init: aValue [
	^ self class
		new: self size + 1
		streamContents: [ :aStream | 
			| acc |
			acc := aStream nextPut: aValue.
			self do: [ :each | acc := aStream nextPut: acc + each ] ]
]
