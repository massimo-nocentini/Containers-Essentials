Extension { #name : #Integer }

{ #category : #'*Containers-Essentials-Outliner' }
Integer >> inspectorCanvasRepresentations [

	<inspectorPresentationOrder: 1010 title: 'Representations'>
	^ RSCanvas new
		  add:
			  (self asShapeSlotsDfsTree:
					   CTSlotDescriptorsVisitorIntegerDetails new);
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Outliner' }
Integer >> inspectorCanvasRepresentationsContext: aContext [

	aContext withoutEvaluator
]
