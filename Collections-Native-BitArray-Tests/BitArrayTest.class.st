"
A BitArrayTest is a test class for testing the behavior of BitArray
"
Class {
	#name : #BitArrayTest,
	#superclass : #TestCase,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Collections-Native-BitArray-Tests'
}

{ #category : #utilities }
BitArrayTest >> imagesPath [
	^ self iceWorkingDirectory / 'images' / 'BitArrays'
]

{ #category : #tests }
BitArrayTest >> testBooleans [
	| ba |
	ba := BitArray
		booleans:
			{true . false . true . true . false . true . true . true . false . false.
			true . true . false . true}.
	self
		export: ba
		path: self imagesPath / 'booleans.png'
		selector: #gtInspectorDotsUsingMondrianBuilder:
]

{ #category : #tests }
BitArrayTest >> testEmpty [
	self
		export: BitArray empty
		path: self imagesPath / 'empty.png'
		selector: #gtInspectorDotsUsingMondrianBuilder:
]

{ #category : #tests }
BitArrayTest >> testNewBits [
	self
		export: (BitArray new: 10 bits: {2 . 3 . 6 . 8 . 10})
		path: self imagesPath / 'newBits.png'
		selector: #gtInspectorDotsUsingMondrianBuilder:
]

{ #category : #tests }
BitArrayTest >> testNewWithAll [
	self
		export: (BitArray new: 10 withAll: false)
			path: self imagesPath / 'withAllFalses.png'
			selector: #gtInspectorDotsUsingMondrianBuilder:;
		export: (BitArray new: 10 withAll: true)
			path: self imagesPath / 'withAllTrues.png'
			selector: #gtInspectorDotsUsingMondrianBuilder:
]

{ #category : #tests }
BitArrayTest >> testTabulate [
	self
		export: (BitArray new: 64 tabulate: #even)
			path: self imagesPath / 'evens.png'
			selector: #gtInspectorDotsUsingMondrianBuilder:;
		export: (BitArray new: 4000 tabulate: [ :i | {true . false} atRandom ])
			path: self imagesPath / 'randomTabulate.png'
			selector: #gtInspectorDotsUsingMondrianBuilder:
]
