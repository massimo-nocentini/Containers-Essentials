Extension { #name : #SortedCollection }

{ #category : #'*Containers-Essentials' }
SortedCollection class >> array: anArray sortUsing: aBlockOrSortFunction [

	^ (self sortUsing: aBlockOrSortFunction)
		  instVarNamed: #array put: anArray;
		  instVarNamed: #firstIndex put: 1;
		  instVarNamed: #lastIndex put: anArray size;
		  yourself
]

{ #category : #'*Containers-Essentials' }
SortedCollection >> merge: anObject [

	^ anObject mergeSortedCollection: self
]

{ #category : #'*Containers-Essentials' }
SortedCollection >> mergeCollection: aCollection [

	^ (self class sortUsing: self sortBlock)
		  addAll: aCollection;
		  mergeSortedCollection: self
]

{ #category : #'*Containers-Essentials' }
SortedCollection >> mergeSortedCollection: aSortedCollection [

	^ self sortBlock = aSortedCollection sortBlock
		  ifTrue: [ 
			  | anArray inversions lessThan |
			  inversions := 0.
			  lessThan := self sortBlock ifNil: [ #<= ].
			  anArray := Array streamContents: [ :aStream | 
				             | myStream itsStream |
				             myStream := self readStream.
				             itsStream := aSortedCollection readStream.
				             [ myStream atEnd or: [ itsStream atEnd ] ] 
					             whileFalse: [ 
						             aStream nextPut:
							             ((lessThan
								               value: myStream peek
								               value: itsStream peek)
								              ifTrue: [ myStream next ]
								              ifFalse: [ 
									              inversions := inversions + myStream sizeUpToEnd.
									              itsStream next ]) ].
				             aStream
					             nextPutAll: myStream upToEnd;
					             nextPutAll: itsStream upToEnd ].

			  inversions -> (self class array: anArray sortUsing: lessThan) ]
		  ifFalse: [ DomainError signal ]
]
