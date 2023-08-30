Class {
	#name : #CTNotebookKeyedValuedOrderedCollection,
	#superclass : #CTKeyedValuedOrderedCollection,
	#instVars : [
		'codePresenter',
		'title',
		'luaState',
		'switch'
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
CTNotebookKeyedValuedOrderedCollection >> doLuaChunk: chunk [

	| size |
	size := self liblua lua_gettop: luaState.

	^ (self liblua luaL_dostring: luaState chunk: chunk)
	  = self liblua LUA_OK
		  ifTrue: [
			  | array newElementsSize |
			  newElementsSize := (self liblua lua_gettop: luaState) - size.
			  array := Array new: newElementsSize.
			  1 to: newElementsSize do: [ :i |
			  array at: i put: (self liblua on: luaState at: size + i) ].
			  array ]
		  ifFalse: [ self liblua on: luaState at: -1 ]
]

{ #category : #'as yet unclassified' }
CTNotebookKeyedValuedOrderedCollection >> hide: block because: reason [

	^ CTNotebookComment new
		  topic: block value;
		  text: reason;
		  yourself
]

{ #category : #initialization }
CTNotebookKeyedValuedOrderedCollection >> initialize [

	super initialize.

	switch := SmallDictionary new
		          at: #title: put: [ :node |
			          CTDFSRBComment withString:
					          '{{<span font_family="Source Sans Pro"  font_size="50pt" variant="small-caps">}}'
					          , node arguments first value , '{{</span>}}' ];
		          at: #hide:because:
		          put: [ :node | node arguments first body ];
		          at: #outside: put: [ :node | node arguments first body ];
		          at: #doLuaChunk:
		          put: [ :node |
			          RBLuaLiteralValueNode value: node arguments first value ];
		          yourself
]

{ #category : #'as yet unclassified' }
CTNotebookKeyedValuedOrderedCollection >> liblua [

	^ LibLua uniqueInstance
]

{ #category : #'as yet unclassified' }
CTNotebookKeyedValuedOrderedCollection >> outside: block [

	^ CTDfsObjectHoder new
		  object: block value;
		  yourself
]

{ #category : #'as yet unclassified' }
CTNotebookKeyedValuedOrderedCollection >> refreshExternalKernels [

	luaState
		ifNil: [ luaState := ExternalAddress null ]
		ifNotNil: [
		luaState isNull ifFalse: [ self liblua lua_close: luaState ] ].

	luaState := self liblua luaL_newstate.

	self liblua luaL_openlibs: luaState
]

{ #category : #accessing }
CTNotebookKeyedValuedOrderedCollection >> title: anObject [

	title := anObject
]

{ #category : #evaluating }
CTNotebookKeyedValuedOrderedCollection >> translateRBMessageNode: node [

	^ switch
		  at: node selector
		  ifPresent: [ :valuable | valuable value: node ]
		  ifAbsent: [ nil ]
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
