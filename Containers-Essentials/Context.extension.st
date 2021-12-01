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

	^ (String streamContents: [ :aStream | 
		   self arguments
			   ifEmpty: [ 
				   aStream
					   nextPut: Character space;
					   nextPutAll: self selector ]
			   ifNotEmpty: [ :args | 
				   | keywords |
				   keywords := $: split: self selector.

				   keywords allButLast with: args do: [ :key :arg | 
					   aStream
						   nextPut: Character space;
						   nextPutAll: key asString;
						   nextPutAll: ': ';
						   nextPutAll: arg asString ] ] ]) allButFirst
]
