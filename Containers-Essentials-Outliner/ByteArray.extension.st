Extension { #name : #ByteArray }

{ #category : #'*Containers-Essentials-Outliner' }
ByteArray >> inspectorCanvasBitsDumpBigEndian [

	<inspectorPresentationOrder: 1010 title: 'Bits dump (big-endian)'>
	^ RSCanvas new
		  add: self asShapeBitsDump;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Outliner' }
ByteArray >> inspectorCanvasBitsDumpBigEndianContext: aContext [

	aContext withoutEvaluator
]
