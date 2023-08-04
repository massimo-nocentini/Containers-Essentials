Class {
	#name : #CTNotebookKeyedValuedOrderedCollection,
	#superclass : #CTKeyedValuedOrderedCollection,
	#instVars : [
		'codePresenter',
		'title'
	],
	#category : #'Containers-Essentials-Outliner-Presenters'
}

{ #category : #visiting }
CTNotebookKeyedValuedOrderedCollection >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCTNotebookKeyedValuedOrderedCollection: self
]

{ #category : #accessing }
CTNotebookKeyedValuedOrderedCollection >> codePresenter [

	^ codePresenter
]

{ #category : #accessing }
CTNotebookKeyedValuedOrderedCollection >> codePresenter: anObject [

	codePresenter := anObject
]

{ #category : #'as yet unclassified' }
CTNotebookKeyedValuedOrderedCollection >> hide: block because: reason [

	^ CTNotebookComment new
		  topic: block value;
		  text: reason;
		  yourself
]

{ #category : #'as yet unclassified' }
CTNotebookKeyedValuedOrderedCollection >> outside: block [

	^ CTDfsObjectHoder new
		  object: block value;
		  yourself
]

{ #category : #accessing }
CTNotebookKeyedValuedOrderedCollection >> title: anObject [

	title := anObject
]

{ #category : #evaluating }
CTNotebookKeyedValuedOrderedCollection >> translateRBMessageNode: node [

	^ node selector = #title:
		  ifTrue: [
			  CTDFSRBComment withString:
				  '<span font_size="50pt">' , node arguments first value
				  , '</span>' ]
		  ifFalse: [
			  node selector = #hide:because:
				  ifTrue: [ node arguments first body ]
				  ifFalse: [
					  node selector = #outside:
						  ifTrue: [ node arguments first body ]
						  ifFalse: [ nil ] ] ]
]

{ #category : #evaluating }
CTNotebookKeyedValuedOrderedCollection >> value [

	| evaluated ast errorFree statements astNodes astNodesRewritten |
	evaluated := OrderedCollection new.

	self
		collection: evaluated;
		keyBlock: [ :anAssoc | anAssoc key ];
		valueBlock: [ :anAssoc | anAssoc value ].

	ast := RBParser parseExpression: codePresenter text.

	errorFree := true.

	statements := ast isSequence
		              ifTrue: [ ast statements ]
		              ifFalse: [ { ast } ].

	astNodes := SortedCollection sortUsing: [ :a :b | a start < b start ].

	astNodes
		addAll: statements;
		addAll: ast allComments.

	astNodesRewritten := astNodes
		                     collect: [ :each |
		                     each translateForNotebook: self ]
		                     as: Array.

	astNodes with: astNodesRewritten do: [ :astNode :astNodeRewritten |
		| value |
		value := astNode isCommentNode
			         ifTrue: [ nil ]
			         ifFalse: [
				         | obj |
				         obj := codePresenter
					                evaluate: astNode sourceCode
					                onCompileError: [
					                Error signal:
						                'Logical inconsistency: RBParser cannot fail.' ]
					                onError: [ :e |
						                errorFree := false.
						                evaluated add: astNode -> e ].

				         obj isObjectHolder
					         ifTrue: [ obj object ]
					         ifFalse: [
						         obj isNotebookHideReason
							         ifTrue: [ obj ]
							         ifFalse: [
								         CTDfsObjectHoder new
									         object: obj;
									         yourself ] ] ].


		(errorFree and: [ astNodeRewritten isNotNil ]) ifTrue: [
			evaluated add: astNodeRewritten -> value ] ]
]
