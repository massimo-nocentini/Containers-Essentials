Class {
	#name : #CTStNotebookPlaygroundPagePresenter,
	#superclass : #StPlaygroundPagePresenter,
	#category : #'Containers-Essentials-Outliner-Presenters'
}

{ #category : #'private commands' }
CTStNotebookPlaygroundPagePresenter class >> baseToolbarCommands [

	^ super baseToolbarCommands , { CTStNotebookPlaygroundDoItCommand }
]

{ #category : #initialization }
CTStNotebookPlaygroundPagePresenter >> initialize [

	super initialize.

	self text interactionModel addBinding:
		(WorkspaceVariable key: #thisNotebook value: self owner notebook)
]

{ #category : #context }
CTStNotebookPlaygroundPagePresenter >> withActivationBlock: aBlock [

	^ activationBlock ifNotNil: aBlock
]
