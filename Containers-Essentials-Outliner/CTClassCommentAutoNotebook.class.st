Class {
	#name : 'CTClassCommentAutoNotebook',
	#superclass : 'CTNotebookKeyedValuedOrderedCollection',
	#category : 'Containers-Essentials-Outliner-Presenters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Presenters'
}

{ #category : 'evaluating' }
CTClassCommentAutoNotebook >> initialize [

	super initialize.

	self codePresenter: (SpCodePresenter new
			 beForScripting;
			 text: self class comment;
			 yourself).
			
	self value
]
