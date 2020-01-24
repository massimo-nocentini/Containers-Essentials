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
	0 to: 50 do: [ :i | 
		self
			export: i skewBinaryCanonicalDenseRepresentation
			path: self imagesPath / ('dense-increment-{0}.png' format: {i})
			selector: #gtInspectorLinksUsingMondrianBuilder: ]
]
