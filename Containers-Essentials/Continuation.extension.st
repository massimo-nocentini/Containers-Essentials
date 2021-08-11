Extension { #name : #Continuation }

{ #category : #'*Containers-Essentials' }
Continuation class >> tries: aSequenceableOfBlocks otherwise: elseBlock [
	^ self currentDo: [ :success | 
		  | localResults |
		  localResults := aSequenceableOfBlocks collect: [ :tryBlock | 
			                  self currentDo: [ :local | 
				                  success value: (tryBlock value: local) ] ].
		  elseBlock cull: localResults ]
]
