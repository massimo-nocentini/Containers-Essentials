Class {
	#name : #RSParametricCurveTest,
	#superclass : #TestCase,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Containers-Essentials-Tests'
}

{ #category : #tests }
RSParametricCurveTest >> testLineDeCasteljauLineClosedControlPoints [

	self
		exportShapeOf:
		RSBasicShapeExamples new lineDeCasteljauLineClosedControlPoints
		accessorBlock: [ :aLine | aLine asGroupWithControlNet asShape ]
]

{ #category : #tests }
RSParametricCurveTest >> testLineDeCasteljauLineNoteBox [

	self
		exportShapeOf: RSBasicShapeExamples new lineDeCasteljauLineNoteBox
		accessorBlock: [ :aLine | aLine asGroupWithControlNet asShape ]
]

{ #category : #tests }
RSParametricCurveTest >> testLineParametricButterfly [

	self exportShapeOf: RSBasicShapeExamples new lineParametricButterfly
]

{ #category : #tests }
RSParametricCurveTest >> testLineParametricHypotrochoid [

	self exportShapeOf:
		RSBasicShapeExamples new lineParametricHypotrochoid
]

{ #category : #tests }
RSParametricCurveTest >> testLineParametricLissajous [

	self exportShapeOf: RSBasicShapeExamples new lineParametricLissajous
]

{ #category : #tests }
RSParametricCurveTest >> testLineParametricNeil [

	self exportShapeOf: RSBasicShapeExamples new lineParametricNeil
]

{ #category : #tests }
RSParametricCurveTest >> testLineParametricTrochoid [

	self exportShapeOf: RSBasicShapeExamples new lineParametricTrochoid
]

{ #category : #tests }
RSParametricCurveTest >> testLineParametricUnitCircle [

	self exportShapeOf: RSBasicShapeExamples new lineParametricUnitCircle
]

{ #category : #tests }
RSParametricCurveTest >> testLinesDeCasteljauLineDegreeElevation [

	self
		exportShapeOf:
		RSBasicShapeExamples new linesDeCasteljauLineDegreeElevation
		accessorBlock: [ :aGroup | 
			| shapes |
			shapes := aGroup
				          with: { 
						          Color gray.
						          Color red.
						          Color blue.
						          Color brown }
				          collect: [ :aLine :aColor | 
					          (aLine asGroupWithControlNetColoured: aColor) asShape ].

			(RSGroup withAll: shapes) asShape ]
]

{ #category : #tests }
RSParametricCurveTest >> testNoteInteger [

	self exportShapeOf: RSBasicShapeExamples new noteInteger
]

{ #category : #tests }
RSParametricCurveTest >> testNoteLoremIpsum [

	self exportShapeOf: RSBasicShapeExamples new noteLoremIpsum
]
