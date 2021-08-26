Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitObject: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsCollapsedSCCsDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeTreeDrawer: CTCollapsedSccDfsPainter new
		  slotDescriptorsContext: aSlotDescriptorsContext
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeTreeDrawer: CTDfsPainter new
		  slotDescriptorsContext: aSlotDescriptorsContext
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsLayeredDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeTreeDrawer: CTLayeredDfsPainter new
		  slotDescriptorsContext: aSlotDescriptorsContext
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsSCCsDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeTreeDrawer: CTSccDfsPainter new
		  slotDescriptorsContext: aSlotDescriptorsContext
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsTopologicallySortedDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeTreeDrawer: CTTopologicalSortDfsPainter new
		  slotDescriptorsContext: aSlotDescriptorsContext
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeTreeDrawer: aDrawer slotDescriptorsContext: aSlotDescriptorsContext [

	^ aSlotDescriptorsContext
		  draw: self
		  using: aDrawer
		  walking: CTDfsWalker new
]
