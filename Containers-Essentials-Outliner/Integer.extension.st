Extension { #name : #Integer }

{ #category : #'*Containers-Essentials-Outliner' }
Integer >> inspectorCanvasRepresentations [

	<inspectorPresentationOrder: 1010 title: 'Representations'>
	| walker shape |
	walker := CTDfsWalker new.

	walker slotDescriptorsVisitor:
		(CTSlotDescriptorsVisitorIntegerDetails new" in: [ :visitor | 
			 | rootDescriptor |
			 rootDescriptor := visitor
				                   newSlotDescriptorFollowerOf:
				                   visitor rootDescriptor
				                   then: [ 
				                   { (visitor newSlotDescriptorSelector: #odd) } ].

			 visitor rootDescriptor: rootDescriptor.

			 visitor ]").

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
