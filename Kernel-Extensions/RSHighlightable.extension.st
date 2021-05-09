Extension { #name : #RSHighlightable }

{ #category : #'*Kernel-Extensions' }
RSHighlightable class >> withStronglyConnectedComponents: aBlock [

	^ self new
		  highlightShapes: aBlock;
		  highlightBorder: (RSBorder new color: Color black);
		  yourself
]
