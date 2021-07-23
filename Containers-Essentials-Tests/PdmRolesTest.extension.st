Extension { #name : #PdmRolesTest }

{ #category : #'*Containers-Essentials-Tests' }
PdmRolesTest >> testPdmRelations [

	| anne schmidt relations project1 project2 |
	anne := 'Anne Konig'.
	schmidt := 'Bauing Schmidt'.

	project1 := 'Project 1'.
	project2 := 'Project 2'.

	relations := { 
		             ((PdmRelation
			               receiver: anne
			               selector: #managesProjectsFor:
			               argument: schmidt)
			              return: (PdmRelationOrderedCollection new
					               add: project1;
					               add: project2;
					               yourself);
			              yourself).
		             ((PdmRelation
			               receiver: anne
			               selector: #isAdministeredBy)
			              return: schmidt;
			              yourself).
		             ((PdmRelation
			               receiver: anne
			               selector: #isEmployedAsHumanResourceManager)
			              return: schmidt;
			              yourself).
		             ((PdmRelation
			               receiver: anne
			               selector: #isOrganizationalPart)
			              return: 'IBS Schmallenberg';
			              yourself).
		             (PdmRelation
			              receiver: anne
			              selector: #managesHumanResources).
		             (PdmRelation receiver: anne selector: #isTechnicalStuff).
		             (PdmRelation receiver: anne selector: #isAccountant).
		             ((PdmRelation receiver: anne selector: #canBeReachedBy)
			              return: (Dictionary new
					               at: #address put: nil;
					               at: #phone1 put: nil;
					               at: #phone2 put: nil;
					               at: #fax put: nil;
					               at: #mobile put: nil;
					               at: #email put: nil;
					               yourself) asKeysAndValuesView;
			              yourself) }.



	self
		exportSlotsGraphOf: anne -> relations
		slotsBlock: [ :anObject | 
			anObject instVarsNamesOrderedCollection collect: [ :each | 
				each noHeader ] ]
]

{ #category : #'*Containers-Essentials-Tests' }
PdmRolesTest >> testPdmRelationsInlineProjects [

	| anne schmidt relations project1 project2 |
	anne := 'Anne Konig'.
	schmidt := 'Bauing Schmidt'.

	project1 := 'Project 1'.
	project2 := 'Project 2'.

	relations := { 
		             ((PdmRelationManagesProjectsFor
			               receiver: anne
			               selector: #managesProjectsFor:
			               argument: schmidt)
			              return: (PdmRelationOrderedCollection new
					               add: project1;
					               add: project2;
					               yourself);
			              yourself).
		             ((PdmRelation
			               receiver: anne
			               selector: #isAdministeredBy)
			              return: schmidt;
			              yourself).
		             ((PdmRelation
			               receiver: anne
			               selector: #isEmployedAsHumanResourceManager)
			              return: schmidt;
			              yourself).
		             ((PdmRelation
			               receiver: anne
			               selector: #isOrganizationalPart)
			              return: 'IBS Schmallenberg';
			              yourself).
		             (PdmRelation
			              receiver: anne
			              selector: #managesHumanResources).
		             (PdmRelation receiver: anne selector: #isTechnicalStuff).
		             (PdmRelation receiver: anne selector: #isAccountant).
		             ((PdmRelationCanBeReachedBy
			               receiver: anne
			               selector: #canBeReachedBy)
			              return: (Dictionary new
					               at: #address put: nil;
					               at: #phone1 put: nil;
					               at: #phone2 put: nil;
					               at: #fax put: nil;
					               at: #mobile put: nil;
					               at: #email put: nil;
					               asKeysAndValuesView);
			              yourself) }.

	self
		exportSlotsGraphOf: (PdmEntity new
				 key: anne;
				 value: relations;
				 yourself)" anne -> relations"
		slotsBlock: [ :anObject | 
			anObject instVarsNamesOrderedCollection collect: [ :each | 
				each noHeader ] ]
]

{ #category : #'*Containers-Essentials-Tests' }
PdmRolesTest >> testRoles [

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
			              return: { 
					              project1.
					              project2 };
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
