Extension { #name : #Object }

{ #category : #'*Collections-Abstract-Visualizations' }
Object >> gtInspectorItemInSequenceableCollection: aCollection at: i usingMondrianBuilder: aMondrian [
	aMondrian shape text.
	aMondrian nodes: {self}
]
