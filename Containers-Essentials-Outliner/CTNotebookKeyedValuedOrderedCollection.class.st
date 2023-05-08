Class {
	#name : #CTNotebookKeyedValuedOrderedCollection,
	#superclass : #CTKeyedValuedOrderedCollection,
	#instVars : [
		'codePresenter'
	],
	#category : #'Containers-Essentials-Outliner-Presenters'
}

{ #category : #visiting }
CTNotebookKeyedValuedOrderedCollection >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCTNotebookKeyedValuedOrderedCollection: self
]

{ #category : #accessing }
CTNotebookKeyedValuedOrderedCollection >> codePresenter [

	^ codePresenter
]

{ #category : #accessing }
CTNotebookKeyedValuedOrderedCollection >> codePresenter: anObject [

	codePresenter := anObject
]

{ #category : #evaluating }
CTNotebookKeyedValuedOrderedCollection >> value [

	| evaluated ast errorFree statements astNodes |
	evaluated := OrderedCollection new.

	self
		collection: evaluated;
		keyBlock: [ :anAssoc | anAssoc key ];
		valueBlock: [ :anAssoc | anAssoc value ].

	ast := RBParser parseExpression: codePresenter text.

	errorFree := true.

	statements := ast isSequence
		              ifTrue: [ ast statements ]
		              ifFalse: [ { ast } ].

	astNodes := SortedCollection sortUsing: [ :a :b | a start < b start ].

	astNodes
		addAll: statements;
		addAll: ast allComments.

	astNodes do: [ :astNode |
		| value |
		value := astNode isCommentNode
			         ifTrue: [ nil ]
			         ifFalse: [
				         codePresenter
					         evaluate: astNode sourceCode
					         onCompileError: [
					         Error signal:
						         'Logical inconsistency: RBParser cannot fail.' ]
					         onError: [ :e |
						         errorFree := false.
						         evaluated add: astNode -> e ] ].

		errorFree ifTrue: [ evaluated add: astNode -> value ] ]
]
