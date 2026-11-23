"
I am the page of a `CTStNotebookPlayground`: my presenter is a `CTStNotebookPlaygroundPagePresenter`.
"
Class {
	#name : 'CTStNotebookPlaygroundPage',
	#superclass : 'StPlaygroundPage',
	#category : 'Containers-Essentials-Outliner-Presenters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Presenters'
}

{ #category : 'inspector compatibility' }
CTStNotebookPlaygroundPage >> defaultObjectInspectorClass [

	^ CTStNotebookPlaygroundPagePresenter
]
