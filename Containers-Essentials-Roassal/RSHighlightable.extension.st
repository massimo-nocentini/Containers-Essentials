Extension { #name : #RSHighlightable }

{ #category : #'*Containers-Essentials-Roassal' }
RSHighlightable class >> withStronglyConnectedComponents: aBlock [

	^ self new
		  highlightShapes: aBlock;
		  highlightBorder: (RSBorder new color: Color black);
		  yourself
]
