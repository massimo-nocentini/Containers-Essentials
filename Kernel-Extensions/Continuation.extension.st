Extension { #name : #Continuation }

{ #category : #'*Kernel-Extensions' }
Continuation class >> tries: aSequenceableOfBlocks otherwise: elseBlock [
	^ self currentDo: [ :success | 
		  | localResults |
		  localResults := aSequenceableOfBlocks collect: [ :tryBlock | 
			                  self currentDo: [ :local | 
				                  success value: (tryBlock value: local) ] ].
		  elseBlock cull: localResults ]
]
