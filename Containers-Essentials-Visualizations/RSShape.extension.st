Extension { #name : #RSShape }

{ #category : #'*Containers-Essentials-Visualizations' }
RSShape >> asShapeQuoted [

	^ self copy
		  model: self;
		  yourself
]
