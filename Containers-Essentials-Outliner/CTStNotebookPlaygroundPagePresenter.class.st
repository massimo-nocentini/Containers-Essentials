"
I am the presenter of a page of a notebook playground. I add the command `CTStNotebookPlaygroundDoItCommand` to the toolbar, and, when I am made, bind the variable `thisNotebook` of the text to the notebook of the `CTStNotebookPlayground` that is my owner then.

`withActivationBlock:` gives my activation block, if I have one, to a block.
"
Class {
	#name : 'CTStNotebookPlaygroundPagePresenter',
	#superclass : 'StPlaygroundPagePresenter',
	#category : 'Containers-Essentials-Outliner-Presenters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Presenters'
}

{ #category : 'private commands' }
CTStNotebookPlaygroundPagePresenter class >> baseToolbarCommands [

	^ super baseToolbarCommands , { CTStNotebookPlaygroundDoItCommand }
]

{ #category : 'initialization' }
CTStNotebookPlaygroundPagePresenter >> initialize [

	super initialize.

	self text interactionModel addBinding:
		(WorkspaceVariable key: #thisNotebook value: self owner notebook)
]

{ #category : 'context' }
CTStNotebookPlaygroundPagePresenter >> withActivationBlock: aBlock [

	^ activationBlock ifNotNil: aBlock
]
