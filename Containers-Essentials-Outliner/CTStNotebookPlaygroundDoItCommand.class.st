Class {
	#name : 'CTStNotebookPlaygroundDoItCommand',
	#superclass : 'StPlaygroundDoItCommand',
	#instVars : [
		'shouldOpenInspector'
	],
	#category : 'Containers-Essentials-Outliner-Presenters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Presenters'
}

{ #category : 'accessing' }
CTStNotebookPlaygroundDoItCommand class >> defaultName [

	^ 'Outline it'
]

{ #category : 'accessing' }
CTStNotebookPlaygroundDoItCommand class >> order [

	^ 40
]

{ #category : 'executing' }
CTStNotebookPlaygroundDoItCommand >> execute [

	context withActivationBlock: [ :aBlock |
		| notebook codePresenter binding |
		codePresenter := self context text.

		binding := codePresenter interactionModel bindingOf: #thisNotebook.

		binding value.

		notebook := binding value
			            codePresenter: codePresenter;
			            value;
			            yourself.

		shouldOpenInspector
			ifTrue: [
				| walker shape |
				walker := CTDfsWalker new.

				shape := notebook asShapeSlotsDfsTree: walker.

				RSCanvas new
					useRTree;
					add: shape;
					addInteraction: RSCanvasController new;
					openWithTitle: (notebook title ifNil: [ 'Notebook' ]) , ' (at '
						, DateAndTime now asLocalStringYMDHM , ')'
				"
		 notebook inspect" ]
			ifFalse: [ aBlock value: notebook ] ]
]

{ #category : 'execution' }
CTStNotebookPlaygroundDoItCommand >> initialize [

	super initialize.

	shouldOpenInspector := true
]
