"
""I am a notebook whose script is the comment of my class: `new` evaluates it. My subclasses write their script in their comment, where the variable `thisNotebook` is the notebook.

```smalltalk
| class |
class := CTClassCommentAutoNotebook newAnonymousSubclass.
class comment: '6 * 7'.
class new asShapeSlotsDfsTree: CTDfsWalker new
```

So this comment has to be Smalltalk code too: it is a Smalltalk comment, between double quotes, which a notebook shows as Markdown.

My `pseudoVariableName` is nil, so `thisNotebook` is a variable as any other. The statements that send it `title:`, `outside:` and `hide:because:` are evaluated, and their values are drawn as `CTNotebookKeyedValuedOrderedCollection` says, but their whole code is shown, instead of the title or of the block. `break` is an error: I do not understand it.""
"
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
