"
I am the command `Outline it` of a notebook playground. I get the notebook from the variable `thisNotebook`, evaluate the text of the page with it, and open the outliner of the notebook on a Roassal canvas, in a window with the title of the notebook, `Notebook` if it has none, and the time.

If `shouldOpenInspector` is false, which it is not at first, I give the notebook to the activation block of the page instead.
"
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
