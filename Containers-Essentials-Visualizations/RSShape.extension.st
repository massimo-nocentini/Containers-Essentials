Extension { #name : #RSShape }

{ #category : #'*Containers-Essentials-Visualizations' }
RSShape >> asCanvas [

	^ RSCanvas new
		  add: self;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSShape >> asShapeQuoted [

	^ self copy
		  model: self;
		  yourself
]
