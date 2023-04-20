Class {
	#name : #CTClassCommentAutoNotebook,
	#superclass : #CTNotebookKeyedValuedOrderedCollection,
	#category : #'Containers-Essentials-Outliner-Presenters'
}

{ #category : #visiting }
CTClassCommentAutoNotebook >> acceptSlotDescriptorsVisitor: aVisitor [

	| ast codePresenter evaluated errorFree statements astNodes notebook |
	evaluated := OrderedCollection new.

	notebook := CTNotebookKeyedValuedOrderedCollection new
		            collection: evaluated;
		            keyBlock: [ :anAssoc | anAssoc key ];
		            valueBlock: [ :anAssoc | anAssoc value ];
		            yourself.

	codePresenter := SpCodePresenter new
		                 beForObject: notebook;
		                 yourself.

	ast := RBParser parseExpression: self class comment.



	errorFree := true.

	statements := ast isSequence
		              ifTrue: [ ast statements ]
		              ifFalse: [ { ast } ].

	astNodes := statements , ast allComments sorted: [ :a :b |
		            a start < b start ].

	astNodes do: [ :astNode |
		| value |
		value := astNode isCommentNode
			         ifTrue: [ nil ]
			         ifFalse: [
				         codePresenter
					         evaluate: astNode sourceCode
					         onCompileError: [ :e |
					         Error signal:
						         'Logical inconsistency: RBParser cannot fail.' ]
					         onError: [ :e |
						         errorFree := false.
						         evaluated add: astNode -> e ] ].

		errorFree ifTrue: [ evaluated add: astNode -> value ] ].

	^ notebook acceptSlotDescriptorsVisitor: aVisitor
]
