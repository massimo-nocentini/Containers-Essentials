"
A SkewBinaryCanonicalNumberTest is a test class for testing the behavior of SkewBinaryCanonicalNumber
"
Class {
	#name : #SkewBinaryCanonicalNumberTest,
	#superclass : #TestCase,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Kernel-NumericalRepresentations-Tests'
}

{ #category : #utilities }
SkewBinaryCanonicalNumberTest >> imagesPath [
	^ self iceWorkingDirectory / 'images' / 'skew-binary-numbers'
]

{ #category : #tests }
SkewBinaryCanonicalNumberTest >> testIncrement [
	| n |
	n := 50.
	0 to: n do: [ :i | 
		self
			export: i skewBinaryCanonicalDenseRepresentation
			path: self imagesPath / ('dense-increment-{1}.png' format: {i})
			selector: #gtInspectorLinksUsingMondrianBuilder: ].
	n - 1 to: 0 by: -1 do: [ :i | 
		self
			export: i skewBinaryCanonicalDenseRepresentation
			path: self imagesPath / ('dense-decrement-{1}.png' format: {i})
			selector: #gtInspectorLinksUsingMondrianBuilder: ]
]
