Extension { #name : #Continuation }

{ #category : #'*Containers-Essentials' }
Continuation >> prependBlock: aBlock [
	^ self class currentDo: [ :k1 | 
		  self value:
			  (aBlock value: (self class currentDo: [ :k2 | k1 value: k2 ])) ]
]

{ #category : #'*Containers-Essentials' }
Continuation class >> tries: aSequenceableOfBlocks otherwise: elseBlock [
	^ self currentDo: [ :success | 
		  | localResults |
		  localResults := aSequenceableOfBlocks collect: [ :tryBlock | 
			                  self currentDo: [ :local | 
				                  success value: (tryBlock value: local) ] ].
		  elseBlock cull: localResults ]
]
