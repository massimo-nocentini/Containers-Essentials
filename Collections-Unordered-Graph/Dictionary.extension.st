Extension { #name : #Dictionary }

{ #category : #'*Collections-Unordered-Graph' }
Dictionary >> gtInspectorGraphViewIn: composite [
	<gtInspectorPresentationOrder: 10>
	^ self associations asGraph gtInspectorGraphViewIn: composite
]
