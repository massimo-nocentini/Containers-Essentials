Extension { #name : #Link }

{ #category : #'*Containers-Essentials-Visualizations' }
Link >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitLink: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Link >> inspectorCanvasNestedSlotsGraph [

	<inspectorPresentationOrder: 150 title: '(Nested) Slots graph'>
	^ RSCanvas new
		  add: self asShapeNestedSlotsDfsTree;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]
