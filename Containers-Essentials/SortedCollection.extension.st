Extension { #name : #SortedCollection }

{ #category : #'*Containers-Essentials' }
SortedCollection class >> array: anArray sortUsing: aBlockOrSortFunction [

	^ (self sortUsing: aBlockOrSortFunction)
		  instVarNamed: #array put: anArray;
		  instVarNamed: #firstIndex put: 1;
		  instVarNamed: #lastIndex put: anArray size;
		  yourself
]
