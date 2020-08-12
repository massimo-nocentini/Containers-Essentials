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
	| n skew |
	n := 10.
	skew := SkewBinaryCanonicalNumber new.
	0 to: n do: [ :i | 
		self
			export: i skewBinaryCanonicalDenseRepresentation
			path: self imagesPath / ('dense-increment-{1}' format: { i })
			selector: #gtInspectorValueLinksChainInCanvas:.
		self
			export: (skew ifZero: [ 0 ~~> nil ] ifNotZero: #yourself)
			path: self imagesPath / ('sparse-increment-{1}' format: { i })
			selector: #gtInspectorValueLinksChainInCanvas:. "this message send allows us to handle the `representation` directly."
		skew := skew increment ].

	"The following is a simple script to generate Markdown code to put into the companion wiki page."
	Character cr join: ((0 to: n) collect: [ :i | 
			 '|{1}| ![](https://github.com/massimo-nocentini/dsst/blob/master/images/skew-binary-numbers/dense-increment-{1}.svg)|![](https://github.com/massimo-nocentini/dsst/blob/master/images/skew-binary-numbers/sparse-increment-{1}.svg)|' 
				 format: { i } ])
]
