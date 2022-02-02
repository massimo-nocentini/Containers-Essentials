Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitObject: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeDfsPainter: aDfsPainter slotDescriptorsContext: aSlotDescriptorsContext [

	| dfsWalker |
	dfsWalker := CTDfsWalker new
		             rootObject: self;
		             slotDescriptorsContext: aSlotDescriptorsContext;
		             shapeBuilder: CTDfsShapeBuilder new;
		             yourself.

	^ aDfsPainter
		  dfsWalker: dfsWalker;
		  value
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsCollapsedSCCsDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeDfsPainter: CTCollapsedSccDfsPainter new
		  slotDescriptorsContext: aSlotDescriptorsContext
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeDfsPainter: CTDfsPainter new
		  slotDescriptorsContext: aSlotDescriptorsContext
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsLayeredDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeDfsPainter: CTLayeredDfsPainter new
		  slotDescriptorsContext: aSlotDescriptorsContext
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsSCCsDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeDfsPainter: CTSccDfsPainter new
		  slotDescriptorsContext: aSlotDescriptorsContext
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsTopologicallySortedDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeDfsPainter: CTTopologicalSortDfsPainter new
		  slotDescriptorsContext: aSlotDescriptorsContext
]
