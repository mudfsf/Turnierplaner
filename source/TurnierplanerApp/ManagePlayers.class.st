Class {
	#name : 'ManagePlayers',
	#superclass : 'Me5BaseView',
	#instVars : [
		'listGrid',
		'data',
		'placeholder'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'Events' }
ManagePlayers >> addPlayerEvent [

	(self data includes: (self placeholder))
	ifFalse: [
		self data add: self placeholder.
	].
	
	self listGrid dataSourceBlock: [ self data	].
	
	self listGrid resetEditedDataGridCells.

	self showSuccessNotificationWithMessage: ('Added row to save Player...')
]

{ #category : 'Initial-Events' }
ManagePlayers >> beforeCreateComponents [

	self data: TurnierplanerApp collectionOfPlayers
]

{ #category : 'Events' }
ManagePlayers >> clearEvent [

	(self data includes: (self placeholder))
	ifTrue: [
		self data remove: self placeholder.
	].
	
	self listGrid dataSourceBlock: [ self data	].
	
	self listGrid resetEditedDataGridCells.

	self showSuccessNotificationWithMessage: ('Cleared Grid...')
]

{ #category : 'Initial-Events' }
ManagePlayers >> createComponents [

	self listGrid: (Me5ListGrid new
		addCssClassColMd12;
		height: '60vh';
		dataSourceBlock: [self data];
		addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
			title: 'First name';
			getterSelector: #firstName;
			setterSelector: #firstName:;
			enableHeaderSort;
			minWidth: 200;
			maxWidth:  'vw 40';
			yourself);
		addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
			title: 'Last name';
			getterSelector: #lastName;
			setterSelector: #lastName:;
			enableHeaderSort;
			enableInitialSort;
			minWidth: 200;
			yourself);
		addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
			title: 'Email';
			getterSelector: #email;
			setterSelector: #email:;
			enableHeaderSort;
			minWidth: 200;
			yourself);
	addDataGridColumnDefinition: (Me5DataGridComponentsHolderColumnDefinition new
		title: 'Action';
		setHorizontalAlignmentToRight;
		componentsHolderBlock: [ 
			:theDataGridComponentsHolderCell :theDataGridComponentsHoldingParameters |
			theDataGridComponentsHolderCell
			addChild: (Me5Button newDanger
				text: 'L&ouml;schen';
				addClickEventSelector: #deletePlayerEvent: eventReceiver: self;
				yourself);
			yourself];
		yourself);
	yourself).
	self
		addChild: (Me5FormPortlet new
		addCssClassColMd12;
		addChildToBody: self listGrid;
		addChildToFootButtonGroup: (Me5Button newSuccess
			icon: Me5I newFasSave; 
			text: 'Speichern';
			addClickEventSelector: #saveEvent eventReceiver: self;
			yourself);
		addChildToFootButtonGroup: (Me5Button newInfo
			icon: Me5I newFasPlus; 
			text: 'Spieler hinzuf&uuml;gen';
			addClickEventSelector: #addPlayerEvent eventReceiver: self;
			yourself);
		addChildToFootButtonGroup: (Me5Button newWarning
			icon: Me5I newFasUndo;
			text: 'Reinigen';
			addClickEventSelector: #clearEvent eventReceiver: self;
			yourself);
		yourself);
	yourself
]

{ #category : 'Initial-Events' }
ManagePlayers >> createModules [

	super createModules.
	
	self addModuleByModuleClass: Me5DataGridModuleBundle.
	self addModuleByModuleClass: Bs4TooltipsterTooltipModuleBundle.
]

{ #category : 'Accessing' }
ManagePlayers >> data [

	^data
]

{ #category : 'Accessing' }
ManagePlayers >> data: aListOfPlayer [

	data := aListOfPlayer
]

{ #category : 'Events' }
ManagePlayers >> deletePlayerEvent: anEvent [

	| thePlayer isSuccessful|
	isSuccessful := false.
	thePlayer := anEvent dataGridComponentsHolderCellObject.
	
	(self data includes:thePlayer)
	ifTrue: [
		 (self data size > 1)
		 ifTrue: [
			self data remove: thePlayer.
			isSuccessful := true.
		 ].
	].
	
	self listGrid dataSourceBlock: [ self data	].
		
	self listGrid resetEditedDataGridCells.

	isSuccessful
	ifTrue: [
		self showSuccessNotificationWithMessage: ('Deleted Player %1 %2...' bindWith: (thePlayer firstName) with: (thePlayer lastName)).
	]
	ifFalse: [
		self showErrorNotificationWithMessage: ('Can not delete last Player...').
	].
	TurnierplanerApp saveCollectionOfPlayers: self data.


]

{ #category : 'Accessing' }
ManagePlayers >> listGrid [

	^listGrid
]

{ #category : 'Accessing' }
ManagePlayers >> listGrid: anObject [

	listGrid := anObject
]

{ #category : 'Accessing' }
ManagePlayers >> placeholder [

	^Player firstName: '' lastName: '' email: ''
]

{ #category : 'Events' }
ManagePlayers >> saveEvent [

	| theNumberOfEditedDataGridRows thePlayers|

	theNumberOfEditedDataGridRows := self listGrid numberOfEditedDataGridRows.

	self listGrid validateEditedDataGridCellsForBlock: [ :eachEditedDataGridCell | | theFieldName theValue |
		theFieldName := (self listGrid dataGridColumnDefinitions at: eachEditedDataGridCell field asNumber) title lowercaseFirstCharacter.
		theValue := eachEditedDataGridCell value.
		theValue isEmptyOrNil
		ifTrue: [
			(theFieldName at: 1) isVowel
			ifFalse: [ eachEditedDataGridCell errorText: 'Please enter a ', theFieldName]
			ifTrue: [ eachEditedDataGridCell errorText: 'Please enter an ', theFieldName ].
		].
	].

	self listGrid hasValidationError
		ifTrue: [^self showErrorNotificationWithMessage: 'Validation failed...'].
	
	self listGrid dataSourceBlock: [ self data	].

	self listGrid editedDataGridRows do: [ :eachEditedDataGridRow |
		eachEditedDataGridRow editedDataGridCells do: [ :eachEditedDataGridCell |
			eachEditedDataGridCell writeValueToObject]].
		
	self listGrid resetEditedDataGridCells.
	
	self showSuccessNotificationWithMessage: ('Saved %1 edited row(s)...' bindWith: theNumberOfEditedDataGridRows).
	
	self parentView tournamentTab resetPlayers: self data.
	TurnierplanerApp saveCollectionOfPlayers: self data

]
