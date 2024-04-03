Class {
	#name : 'CTStNotebookPlayground',
	#superclass : 'StPlaygroundPresenter',
	#instVars : [
		'notebook'
	],
	#category : 'Containers-Essentials-Outliner-Presenters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Presenters'
}

{ #category : 'accessing' }
CTStNotebookPlayground class >> defaultTitle [ 

	^ 'Notebook'
]

{ #category : 'initialization' }
CTStNotebookPlayground class >> initialize [
	"Make playground active by default"

	self register
]

{ #category : 'world menu' }
CTStNotebookPlayground class >> menuCommandOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Notebook)
		parent: #InputOutput;
		action: [ Smalltalk tools notebook open ];
		order: 1;
		keyText: 'o, n';
		help:
			'A window used as a scratchpad area where fragments of Pharo code can be entered, stored, edited, and evaluated.';
		icon: (self iconNamed: #workspace)
]

{ #category : 'tools registry' }
CTStNotebookPlayground class >> register [
	"Add ourselves to registry. See [Smalltalk tools]"

	<script>
	super register
]

{ #category : 'tools registry' }
CTStNotebookPlayground class >> registerToolsOn: registry [
	"Add ourselves to registry. See [Smalltalk tools]"

	registry register: self as: #notebook
]

{ #category : 'initialization' }
CTStNotebookPlayground >> initialize [

	self notebook: (CTNotebookKeyedValuedOrderedCollection new
			 pseudoVariableName: #thisNotebook;
			 yourself).

	super initialize
]

{ #category : 'private - factory' }
CTStNotebookPlayground >> newDefaultPlaygroundPage [

	^ CTStNotebookPlaygroundPage new
]

{ #category : 'accessing' }
CTStNotebookPlayground >> notebook [

	^ notebook
]

{ #category : 'accessing' }
CTStNotebookPlayground >> notebook: anObject [

	notebook := anObject
]
