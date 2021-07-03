Extension { #name : #RSTreeLayoutTest }

{ #category : #'*Containers-Essentials-Tests' }
RSTreeLayoutTest >> testRoles [

	| anne schmidt relations eb map project1 project2 edges |
	anne := 'Anne Konig'.
	schmidt := 'Bauing Schmidt'.

	project1 := 'Project 1'.
	project2 := 'Project 2'.

	relations := { 
		             ((MessageSent
			               receiver: anne
			               selector: #managesProjectsFor:
			               argument: schmidt)
			              return: project1;
			              yourself).
		             ((MessageSent
			               receiver: anne
			               selector: #managesProjectsFor:
			               argument: schmidt)
			              return: project2;
			              yourself) }.

	relations inspect.

	map := IdentityDictionary new.

	{ 
		anne.
		schmidt.
		project1.
		project2 } do: [ :each | 
		map at: each put: (RSLabel new
				 text: each;
				 draggable;
				 yourself) ].

	canvas := RSCanvas new.
	shapes := map values.
	canvas addAll: map values.
	eb := RSLineBuilder arrowedLine
		      canvas: canvas;
		      withBorderAttachPoint;
		      yourself.
	edges := relations collect: [ :each | 
		         | edge |
		         edge := eb
			                 edgeFrom: (map at: each receiver)
			                 to: (map at: each return).
		         edge
			         model: each;
			         addInteraction: (RSLabeled new
					          text: [ :o | 
						          each selector , (each arguments
								           ifEmpty: [ '' ]
								           ifNotEmpty: [ :args | ' ' , args first asString ]) ];
					          yourself);
			         yourself ].

	RSForceBasedLayout new
		charge: -300;
		on: shapes edges: edges.

	canvas
		@ RSCanvasController;
		zoomToFit;
		open
]
