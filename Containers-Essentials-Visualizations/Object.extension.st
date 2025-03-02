Extension { #name : 'Object' }

{ #category : '*Containers-Essentials-Visualizations' }
Object >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitObject: self
]

{ #category : '*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsCollapsedSCCsDfsTree: dfsWalker [

	^ CTCollapsedSccDfsPainter new
		  dfsWalker: dfsWalker;
		  value: self
]

{ #category : '*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsDfsTree: dfsWalker [

	^ CTDfsPainter new
		  dfsWalker: dfsWalker;
		  value: self
]

{ #category : '*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsLayeredDfsTree: dfsWalker [

	^ CTLayeredDfsPainter new
		  dfsWalker: dfsWalker;
		  value: self
]

{ #category : '*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsSCCsDfsTree: dfsWalker [

	^ CTSccDfsPainter new
		  dfsWalker: dfsWalker;
		  value: self
]

{ #category : '*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsTopologicallySortedDfsTree: dfsWalker [

	^ CTTopologicalSortDfsPainter new
		  dfsWalker: dfsWalker;
		  value: self
]
