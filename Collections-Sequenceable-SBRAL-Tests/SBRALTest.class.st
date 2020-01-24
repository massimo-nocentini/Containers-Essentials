"
A SBRALTest is a test class for testing the behavior of SBRAL
"
Class {
	#name : #SBRALTest,
	#superclass : #TestCase,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Collections-Sequenceable-SBRAL-Tests'
}

{ #category : #utilities }
SBRALTest >> imagesPath [
	^ self iceWorkingDirectory / 'images' / 'SBRALs'
]

{ #category : #tests }
SBRALTest >> testIncrement [
	| n |
	n := 20.
	((1 to: n) withIndexCollect: #->)
		inject: SBRAL new
		into: [ :aSBRAL :assoc | 
			self
				export: (aSBRAL add: assoc key)
				path:
					self imagesPath
						/
							('{1}-add-{2}.png'
								format:
									{n.
									assoc value})
				selector: #gtInspectorTreesUsingMondrianBuilder: ]
]

{ #category : #tests }
SBRALTest >> testSorted [
	<gtExample>
	| n |
	n := 200.
	^ self
		export: ((1 to: n) inject: SBRAL new into: #add:)
		path: self imagesPath / ('{1}-ordered.png' format: {n})
		selector: #gtInspectorTreesUsingMondrianBuilder:
]
