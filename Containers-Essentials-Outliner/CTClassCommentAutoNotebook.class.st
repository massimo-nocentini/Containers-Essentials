Class {
	#name : 'CTClassCommentAutoNotebook',
	#superclass : 'CTNotebookKeyedValuedOrderedCollection',
	#category : 'Containers-Essentials-Outliner-Presenters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Presenters'
}

{ #category : 'evaluating' }
CTClassCommentAutoNotebook >> initialize [

	| presenter |
	super initialize.

	presenter := SpCodePresenter new
		             beForScripting;
		             yourself.

	presenter interactionModel addBinding:
		(WorkspaceVariable key: #thisNotebook value: self).

	presenter text: self class comment.

	self codePresenter: presenter.

	self value
]
