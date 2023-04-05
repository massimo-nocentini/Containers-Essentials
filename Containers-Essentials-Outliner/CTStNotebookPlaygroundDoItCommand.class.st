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

	| ast codePresenter evaluated errorFree astNodes |
	codePresenter := context text.
	ast := RBParser parseExpression: codePresenter text.

	evaluated := OrderedCollection new.

	errorFree := true.

	astNodes := ast statements , ast allComments sorted: [ :a :b |
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

	CTKeyedValuedOrderedCollection new
		collection: evaluated;
		keyBlock: [ :anAssoc | anAssoc key formattedCode ];
		valueBlock: [ :anAssoc | anAssoc value ];
		inspect
]
