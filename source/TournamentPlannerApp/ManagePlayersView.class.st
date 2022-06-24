Class {
	#name : 'ManagePlayersView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'listGrid',
		'data',
		'placeholder'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Events' }
ManagePlayersView >> addPlayerEvent [
	
	"<^self>"
	"Adds empty row to listGrid"

	(self data includes: self placeholder)
		ifFalse: [self data add: self placeholder].
	self listGrid dataSourceBlock: [self data].
	self listGrid resetEditedDataGridCells.
	self showSuccessNotificationWithMessage: ('Leere Zeile eingef&uuml;gt')
]

{ #category : 'Initial-Events' }
ManagePlayersView >> beforeCreateComponents [

	"This method is called before #createComponents.
	 Sets data."
	
	self data: TournamentPlannerApp collectionOfPlayers data
]

{ #category : 'Events' }
ManagePlayersView >> clearEvent [

	"<^self>"
	"Removes empty row from listGrid"

	(self data includes: self placeholder)
		ifTrue: [self data remove: self placeholder].
	self listGrid dataSourceBlock: [self data].
	self listGrid resetEditedDataGridCells.
	self showSuccessNotificationWithMessage: ('Tabelle bereinigt')
]

{ #category : 'Initial-Events' }
ManagePlayersView >> createComponents [

	"<^self>"
	"Entry point for creating components.
	 Sets listGrid"

	self listGrid: (Me5ListGrid new
		addCssClassColMd12;
		height: '60vh';
		dataSourceBlock: [self data];
		addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
			title: 'Vorname';
			getterSelector: #firstName;
			setterSelector: #firstName:;
			enableHeaderSort;
			minWidth: 200;
			yourself);
		addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
			title: 'Nachname';
			getterSelector: #lastName;
			setterSelector: #lastName:;
			enableHeaderSort;
			enableInitialSort;
			minWidth: 200;
			yourself);
		addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
			title: 'E-Mail';
			getterSelector: #email;
			setterSelector: #email:;
			enableHeaderSort;
			minWidth: 200;
			yourself);
		addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
			title: 'K&uumlrzel';
			getterSelector: #symbol;
			setterSelector: #symbol:;
			enableHeaderSort;
			minWidth: 200;
			yourself);
		addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
			title: 'Guthaben';
			getterSelector: #money;
			setterSelector: #money:;
			enableHeaderSort;
			minWidth: 200;
			yourself);
		addDataGridColumnDefinition: (Me5DataGridComponentsHolderColumnDefinition new
			title: 'Aktion';
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
	
	self addChild: (Me5H1 new 
			text: 'Admin-Tools';
			addCssClassTextCenter;
			yourself);
		addChild: Me5Hr new;
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
ManagePlayersView >> createModules [

	"<^self>"
	"Creates and adds the modules which should be embedded for this view."

	super createModules.
	
	self addModuleByModuleClass: Me5DataGridModuleBundle.
	self addModuleByModuleClass: Bs4TooltipsterTooltipModuleBundle
]

{ #category : 'Accessing' }
ManagePlayersView >> data [

	"<^hOf Collection of: {iOf Player}>"
	"Answer the data of the receiver"

	^data
]

{ #category : 'Accessing' }
ManagePlayersView >> data: aPlayerCollection [

	"<aPlayerCollection: hOf Collection of: {iOf Player}, ^self>"
	"Set the data of the receiver"

	data := aPlayerCollection
]

{ #category : 'Events' }
ManagePlayersView >> deletePlayerEvent: anEvent [

	"<anEvent: iOf Me5Event, ^self>"
	"Deletes Player from listGrid and memory"

	| thePlayer isSuccessfullBoolean |
	
	isSuccessfullBoolean := false.
	thePlayer := anEvent dataGridComponentsHolderCellObject.
	((self data includes: thePlayer) and: [self data size > 1])
		ifTrue: [
			self data remove: thePlayer.
			isSuccessfullBoolean := true].
	self listGrid dataSourceBlock: [self data].
	self listGrid resetEditedDataGridCells.
	isSuccessfullBoolean
		ifTrue: [self showSuccessNotificationWithMessage: ('Spieler %1 gel&ouml;scht!' 
			bindWith: thePlayer asString)]
		ifFalse: [self showErrorNotificationWithMessage: ('Der letzte Spieler kann nicht gel&ouml;scht werden!')].		
	TournamentPlannerApp saveCollectionOfPlayers: self data
]

{ #category : 'Accessing' }
ManagePlayersView >> listGrid [

	"<^iOf ListGrid>"
	"Answer the listGrid of the receiver"

	^listGrid
]

{ #category : 'Accessing' }
ManagePlayersView >> listGrid: aListGrid [

	"<aListGrid: iOf ListGrid, ^self>"
	"Set the listGrid of the receiver"

	listGrid := aListGrid
]

{ #category : 'Accessing' }
ManagePlayersView >> placeholder [
	
	"<^iOf Player>"
	"Answer the placeholder of the receiver"

	^Player newWithFirstName: ''  lastName: ''  email: '' 
]

{ #category : 'Events' }
ManagePlayersView >> saveEvent [
	
	"<^self>"
	"Adds Player to listGrid and memory"

	| theNumberOfEditedDataGridRows |

	theNumberOfEditedDataGridRows := self listGrid numberOfEditedDataGridRows.
	self listGrid validateEditedDataGridCellsForBlock: [ :eachEditedDataGridCell | | theFieldName theValue |
		theFieldName := (self listGrid dataGridColumnDefinitions at: eachEditedDataGridCell field asNumber) 
			title lowercaseFirstCharacter.
		theValue := eachEditedDataGridCell value.
		theValue isEmptyOrNil
			ifTrue: [
					eachEditedDataGridCell errorText: ('Bitte geben sie ein %1 ein' bindWith: theFieldName)]].
	self listGrid hasValidationError
		ifTrue: [^self showErrorNotificationWithMessage: 'Validierung fehlgeschlagen...'].
	self listGrid dataSourceBlock: [self data].
	self listGrid editedDataGridRows do: [ :eachEditedDataGridRow |
		eachEditedDataGridRow editedDataGridCells do: [ :eachEditedDataGridCell |
			eachEditedDataGridCell writeValueToObject]].
	self listGrid resetEditedDataGridCells.
	self showSuccessNotificationWithMessage: ('%1 bearbeitete Reihe(n) gespeichert...' 
		bindWith: theNumberOfEditedDataGridRows).
	TournamentPlannerApp saveCollectionOfPlayers: self data
]
