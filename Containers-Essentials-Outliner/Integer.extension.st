Extension { #name : #Integer }

{ #category : #'*Containers-Essentials-Outliner' }
Integer >> inspectorCanvasRepresentations [

	<inspectorPresentationOrder: 1010 title: 'Representations'>
	| walker shape |
	walker := CTDfsWalker on: self.

	walker slotDescriptorsContext:
		CTSlotDescriptorsVisitorIntegerDetails new.

	shape := self asShapeSlotsDfsTree: walker.

	^ RSCanvas new
		  add: shape;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Outliner' }
Integer >> inspectorCanvasRepresentationsContext: aContext [

	aContext withoutEvaluator
]
