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
BitArrayTest >> booleansBitArray [
	^ BitArray
		booleans:
			{true . false . true . true . false . true . true . true . false . false.
			true . true . false . true}
]

{ #category : #utilities }
BitArrayTest >> imagesPath [
	^ self iceWorkingDirectory / 'images' / 'BitArrays'
]

{ #category : #tests }
BitArrayTest >> testBitOf [
	| ba |
	ba := self booleansBitArray.
	self
		assert: ((1 to: ba nbits) collect: [ :i | ba at: i ])
		equals:
			#(true false true true false true true true false false true true false true)
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
BitArrayTest >> testExtendWithAll [
	| ba |
	ba := self booleansBitArray.
	self
		export: (ba extend: ba nbits + 4 withAll: false)
			path: self imagesPath / 'extendWithFalses.png'
			selector: #gtInspectorDotsUsingMondrianBuilder:;
		export: (ba extend: ba nbits + 4 withAll: true)
			path: self imagesPath / 'extendWithTrues.png'
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
BitArrayTest >> testShiftToTheLeft [
	<gtExample>
	| ba |
	ba := self booleansBitArray.
	^ (0 to: ba nbits)
		collect: [ :i | 
			self
				export: ba << i
				path: self imagesPath / ('lshift-{1}.png' format: {i})
				selector: #gtInspectorDotsUsingMondrianBuilder: ]
]

{ #category : #tests }
BitArrayTest >> testShiftToTheRight [
	<gtExample>
	| ba |
	ba := self booleansBitArray.
	^ (0 to: ba nbits)
		collect: [ :i | 
			self
				export: ba >> i
				path: self imagesPath / ('rshift-{1}.png' format: {i})
				selector: #gtInspectorDotsUsingMondrianBuilder: ]
]

{ #category : #tests }
BitArrayTest >> testSlice [
	<gtExample>
	| ba nbits |
	ba := self booleansBitArray.
	nbits := ba nbits.
	^ (1 to: nbits + 1)
		collect: [ :i | 
			self
				export: (ba slice: i len: nbits - i + 1)
				path: self imagesPath / ('slice-{1}.png' format: {i})
				selector: #gtInspectorDotsUsingMondrianBuilder: ]
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
