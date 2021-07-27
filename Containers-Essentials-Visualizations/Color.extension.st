Extension { #name : #Color }

{ #category : #'*Containers-Essentials-Visualizations' }
Color >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitColor: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Color >> asShapeColoredBox [

	^ RSBox new
		  color: self;
		  model: self;
		  cornerRadius: Float goldenRatio double;
		  yourself
]
