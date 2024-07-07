Class {
	#name : 'CTNotebookKeyedValuedOrderedCollection',
	#superclass : 'CTKeyedValuedOrderedCollection',
	#instVars : [
		'codePresenter',
		'title',
		'switch',
		'pseudoVariableName'
	],
	#category : 'Containers-Essentials-Outliner-Presenters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Presenters'
}

{ #category : 'visiting' }
CTNotebookKeyedValuedOrderedCollection >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCTNotebookKeyedValuedOrderedCollection: self
]

{ #category : 'accessing' }
CTNotebookKeyedValuedOrderedCollection >> codePresenter [

	^ codePresenter
]

{ #category : 'accessing' }
CTNotebookKeyedValuedOrderedCollection >> codePresenter: anObject [

	codePresenter := anObject
]

{ #category : 'as yet unclassified' }
CTNotebookKeyedValuedOrderedCollection >> hide: block because: reason [

	^ CTNotebookComment new
		  topic: block value;
		  text: reason;
		  yourself
]

{ #category : 'initialization' }
CTNotebookKeyedValuedOrderedCollection >> initialize [

	super initialize.

	switch := Dictionary new
		          at: #title: put: [ :node |
			          CTDFSRBComment withString:
					          '{{<span font_family="Source Sans Pro"  font_size="50pt" variant="small-caps">}}'
					          , node arguments first value , '{{</span>}}' ];
		          at: #hide:because:
		          put: [ :node | node arguments first body ];
		          at: #outside: put: [ :node | node arguments first body ];
		          yourself
]

{ #category : 'as yet unclassified' }
CTNotebookKeyedValuedOrderedCollection >> liblua [

	^ LibLua uniqueInstance implementationPrimitive
]

{ #category : 'as yet unclassified' }
CTNotebookKeyedValuedOrderedCollection >> outside: block [

	^ CTDfsObjectHoder new
		  object: block value;
		  yourself
]

{ #category : 'accessing' }
CTNotebookKeyedValuedOrderedCollection >> pseudoVariableName: anObject [

	pseudoVariableName := anObject
]

{ #category : 'evaluating' }
CTNotebookKeyedValuedOrderedCollection >> shouldBreakOnNode: astNode ifTrue: aBlock [

	(astNode isMessage and: [
		 astNode receiver isVariable and: [
			 astNode receiver name = pseudoVariableName and: [
				 astNode selector == #break ] ] ]) ifTrue: [ aBlock value ]
]

{ #category : 'accessing' }
CTNotebookKeyedValuedOrderedCollection >> title [

	^ title
]

{ #category : 'accessing' }
CTNotebookKeyedValuedOrderedCollection >> title: anObject [

	title := anObject
]

{ #category : 'evaluating' }
CTNotebookKeyedValuedOrderedCollection >> translateRBMessageNode: node [

	^ switch
		  at: node selector
		  ifPresent: [ :valuable | valuable value: node ]
		  ifAbsent: [ node ]
]

{ #category : 'evaluating' }
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
			                     each
				                     translateForNotebook: self
				                     pseudoNotebookVariableName:
				                     pseudoVariableName ]
		                     as: Array.

	astNodes with: astNodesRewritten do: [ :astNode :astNodeRewritten |
		| value |
		value := astNode isCommentNode
			         ifTrue: [ nil ]
			         ifFalse: [
				         | obj |
				         self shouldBreakOnNode: astNode ifTrue: [ ^ self ].

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
