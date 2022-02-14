Class {
	#name : #RSParametricCurveTest,
	#superclass : #TestCase,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Containers-Essentials-Roassal'
}

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
