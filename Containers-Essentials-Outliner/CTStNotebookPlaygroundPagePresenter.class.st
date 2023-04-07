Class {
	#name : #CTStNotebookPlaygroundPagePresenter,
	#superclass : #StPlaygroundPagePresenter,
	#category : #'Containers-Essentials-Outliner-Presenters'
}

{ #category : #'private commands' }
CTStNotebookPlaygroundPagePresenter class >> baseToolbarCommands [

	^ super baseToolbarCommands , { CTStNotebookPlaygroundDoItCommand }
]

{ #category : #'as yet unclassified' }
CTStNotebookPlaygroundPagePresenter >> withActivationBlock: aBlock [

	^ activationBlock ifNotNil: aBlock
]
