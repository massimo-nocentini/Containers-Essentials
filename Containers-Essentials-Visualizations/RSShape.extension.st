Extension { #name : #RSShape }

{ #category : #'*Containers-Essentials-Visualizations' }
RSShape >> asShapeQuoted [

	^ self copy
		  model: self;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSShape >> sameColorAsBorderColor [

	self color: self border color
]
