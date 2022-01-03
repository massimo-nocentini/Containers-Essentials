Extension { #name : #PositionableStream }

{ #category : #'*Containers-Essentials' }
PositionableStream >> merge: aStream sortBlock: lessThan on: outStream [

	^ self
		  merge: aStream
		  sortBlock: lessThan
		  on: outStream
		  inversionsOrNil: nil
]

{ #category : #'*Containers-Essentials' }
PositionableStream >> merge: aStream sortBlock: lessThan on: outStream inversionsOrNil: invStream [

	| inversions |
	inversions := 0.

	[ self atEnd or: [ aStream atEnd ] ] whileFalse: [ 
		| anObject myNext itsNext |
		myNext := self peek.
		itsNext := aStream peek.

		anObject := (lessThan value: myNext value: itsNext)
			            ifTrue: [ self next ]
			            ifFalse: [ 
				            invStream ifNotNil: [ 
					            self copy upToEnd do: [ :each | 
						            invStream nextPut: itsNext inversion: each ] ].

				            inversions := inversions + self sizeUpToEnd.
				            aStream next ].

		outStream nextPut: anObject ].

	outStream
		nextPutAll: self upToEnd;
		nextPutAll: aStream upToEnd.

	^ inversions
]

{ #category : #'*Containers-Essentials' }
PositionableStream >> sizeUpToEnd [

	^ readLimit - position
]
