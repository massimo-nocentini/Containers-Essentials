Extension { #name : #RSBoundingShape }

{ #category : #'*Containers-Essentials-Roassal' }
RSBoundingShape class >> nilShape [

	^ RSComposite new
		  extent: 0 asPoint;
		  yourself
]
