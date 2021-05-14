Extension { #name : #SequenceableCollection }

{ #category : #'*Containers-Essentials' }
SequenceableCollection >> injectBRGC: anObject intoIn: iBlock intoOut: oBlock [

	^ ((1 to: self size) inject: 0 -> anObject into: [ :anAssoc :each | 
		   | nextCode index code block acc |
		   code := anAssoc key.
		   acc := anAssoc value.
		   nextCode := each bitBRGC.
		   index := (code bitXor: nextCode) highBit.
		   block := (nextCode bitAt: index) = 0
			            ifTrue: [ oBlock ]
			            ifFalse: [ iBlock ].
		   acc := block cull: acc cull: (self at: index) cull: index.
		   nextCode -> acc ]) value
]
