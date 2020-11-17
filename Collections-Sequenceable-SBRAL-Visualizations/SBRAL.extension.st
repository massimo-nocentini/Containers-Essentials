Extension { #name : #SBRAL }

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRAL >> associations [
	^ representation
		ifNotNil: [ representation value ~~> self cdr associations ]
]

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRAL >> gtInspectorTreesInCanvas: aCanvas [
	| shapes |
	shapes := representation asLinkedList collect: [ :anAssociation | 
		          | c |
		          c := anAssociation value gtInspectorTreeViewUsingCanvas:
			               RSCanvas new.
		          (RSComposite new
			           shapes: { c asShape };
			           padding: 5;
			           withBorder;
			           yourself) @ (RSLabeled new text: anAssociation key) ].
	RSVerticalLineLayout new
		alignCenter;
		verticalGap: 20;
		applyOn: shapes.
	^ aCanvas
		  addAll: shapes;
		  yourself
]

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRAL >> gtInspectorTreesViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal3
		  title: 'Trees';
		  initializeCanvas: [ 
			  | c |
			  c := self gtInspectorTreesInCanvas: RSCanvas new.
			  c @ RSCanvasController ];
		  yourself
]
