Extension { #name : #Context }

{ #category : #'*Containers-Essentials' }
Context >> asStringInterpolationOfReceiverSelectorArguments [

	^ String streamContents: [ :aStream | 
		  aStream nextPutAll: receiver asString.

		  self arguments
			  ifEmpty: [ 
				  aStream
					  nextPutAll: ' ';
					  nextPutAll: self selector ]
			  ifNotEmpty: [ :args | 
				  | keywords |
				  keywords := $: split: self selector.

				  keywords allButLast with: args do: [ :key :arg | 
					  aStream
						  nextPutAll: ' ';
						  nextPutAll: key asString;
						  nextPutAll: ': ';
						  nextPutAll: arg asString ] ] ]
]
