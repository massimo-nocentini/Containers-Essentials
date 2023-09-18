Class {
	#name : 'RBWolframExpressionValueNode',
	#superclass : 'RBLiteralValueNode',
	#instVars : [
		'wolframLink'
	],
	#category : 'Containers-Essentials-Outliner-Presenters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Presenters'
}

{ #category : 'converting' }
RBWolframExpressionValueNode >> asVarShapeUsingPresenter: codePresenter clientSlotDescriptorVisitor: visitor [

	| block evaluated |
	block := codePresenter
		         evaluate: self value sourceCode
		         onCompileError: [
		         Error signal:
			         'Logical inconsistency: RBParser cannot fail.' ]
		         onError: [ :e |  ].

	evaluated := block value: self wolframLink.

	^ evaluated asTeXifiedShape asCompositeShape
]

{ #category : 'accessing' }
RBWolframExpressionValueNode >> wolframLink [

	^ wolframLink
]

{ #category : 'accessing' }
RBWolframExpressionValueNode >> wolframLink: anObject [

	wolframLink := anObject
]
