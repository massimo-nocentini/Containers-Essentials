Class {
	#name : 'CTStNotebookPlaygroundDoItCommand',
	#superclass : 'StPlaygroundDoItCommand',
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

{ #category : 'execution' }
CTStNotebookPlaygroundDoItCommand >> execute [

	context withActivationBlock: [ :aBlock |
		| notebook codePresenter binding |
		codePresenter := self context text.

		binding := codePresenter interactionModel bindingOf: #thisNotebook.

		binding value refreshExternalKernels.

		notebook := binding value
			            codePresenter: codePresenter;
			            value;
			            yourself.

		"aBlock value: notebook"
		notebook inspect ]
]
