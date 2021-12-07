Extension { #name : #Context }

{ #category : #'*Containers-Essentials' }
Context >> asStringInterpolationOfReceiverSelectorArguments [

	^ String streamContents: [ :aStream | 
		  aStream
			  nextPutAll: receiver asString;
			  nextPut: Character space;
			  nextPutAll: self asStringInterpolationOfSelectorArguments ]
]

{ #category : #'*Containers-Essentials' }
Context >> asStringInterpolationOfSelectorArguments [

	| interpolation |
	interpolation := String streamContents: [ :aStream | 
		                 self arguments
			                 ifEmpty: [ 
				                 aStream
					                 nextPut: Character space;
					                 nextPutAll: self selector ]
			                 ifNotEmpty: [ :args | 
				                 self method isBinarySelector
					                 ifTrue: [ 
						                 self assert: args size = 1.
						                 aStream
							                 nextPut: Character space;
							                 nextPutAll: self selector;
							                 nextPut: Character space;
							                 nextPutAll: args anyOne asString ]
					                 ifFalse: [ 
						                 | keywords |
						                 keywords := $: split: self selector.
						                 keywords allButLast
							                 with: args
							                 do: [ :key :arg | 
								                 aStream
									                 nextPut: Character space;
									                 nextPutAll: key asString;
									                 nextPutAll: ': ';
									                 nextPutAll: arg asString ] ] ] ].

	^ interpolation allButFirst
]
