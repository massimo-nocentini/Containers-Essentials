Class {
	#name : 'RBWolframLiteralValueNode',
	#superclass : 'RBLiteralValueNode',
	#instVars : [
		'wolframLink'
	],
	#category : 'Containers-Essentials-Outliner-Presenters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Presenters'
}

{ #category : 'converting' }
RBWolframLiteralValueNode >> asVarShapeUsingPresenter: codePresenter clientSlotDescriptorVisitor: visitor [

	| expression |
	expression := wolframLink ! self value.

	^ expression asTeXifiedShape asCompositeShape
]

{ #category : 'accessing' }
RBWolframLiteralValueNode >> wolframLink [

	^ wolframLink
]

{ #category : 'accessing' }
RBWolframLiteralValueNode >> wolframLink: anObject [

	wolframLink := anObject
]
