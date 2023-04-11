Class {
	#name : #CTStNotebookPlaygroundDoItCommand,
	#superclass : #StPlaygroundDoItCommand,
	#category : #'Containers-Essentials-Outliner-Presenters'
}

{ #category : #accessing }
CTStNotebookPlaygroundDoItCommand class >> defaultName [

	^ 'Outline it'
]

{ #category : #accessing }
CTStNotebookPlaygroundDoItCommand class >> order [

	^ 40
]

{ #category : #execution }
CTStNotebookPlaygroundDoItCommand >> execute [

	context withActivationBlock: [ :aBlock |
		| ast codePresenter evaluated errorFree astNodes notebook statements |
		codePresenter := context text.
		ast := RBParser parseExpression: codePresenter text.

		evaluated := OrderedCollection new.

		errorFree := true.

		statements := ast isSequence
			              ifTrue: [ ast statements ]
			              ifFalse: [ { ast } ].

		astNodes := statements , ast allComments sorted: [ :a :b |
			            a start < b start ].

		astNodes do: [ :astNode |
			| value |
			value := codePresenter
				         evaluate: astNode sourceCode
				         onCompileError: [
				         Error signal:
					         'Logical inconsistency: RBParser cannot fail.' ]
				         onError: [ :e |
					         errorFree := false.
					         evaluated add: astNode -> e ].

			errorFree ifTrue: [ evaluated add: astNode -> value ] ].

		notebook := CTNotebookKeyedValuedOrderedCollection new
			            collection: evaluated;
			            keyBlock: [ :anAssoc | anAssoc key ];
			            valueBlock: [ :anAssoc | anAssoc value ];
			            yourself.

		aBlock value: notebook ]
]
