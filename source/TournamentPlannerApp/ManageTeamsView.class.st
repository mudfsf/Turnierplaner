Class {
	#name : 'ManageTeamsView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'teamsRow',
		'modalTextFieldTeamName',
		'modalMultiComboBoxTeamMembers',
		'teamToDelete',
		'dictionaryOfTeamDivs'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
ManageTeamsView >> createComponents [

	"<^iOf Me5Div>"
	"Create the teamsTab where we can see and manage all teams"

	| theTeamMemberDiv theResultDiv theTeamList theCollectionOfTeamMemberCollections thePersons textFieldTeamName multiComboBoxTeamMembers theTeamDiv |

	self dictionaryOfTeamDivs: Dictionary new.
	thePersons := OrderedCollection new.
	TournamentPlannerApp collectionOfPlayers data do: [ :eachPerson |
		thePersons add: ('%1 %2' bindWith: eachPerson firstName with: eachPerson lastName)].
	theTeamList := OrderedCollection new.
	theCollectionOfTeamMemberCollections := OrderedCollection new.
	TournamentPlannerApp collectionOfTeams data do: [ :eachTeam |
		| eachPlayerList |
		theTeamList add: eachTeam teamName.
		eachPlayerList := OrderedCollection new.
		eachTeam members do: [ :eachPlayer |
			eachPlayerList add: eachPlayer].
		theCollectionOfTeamMemberCollections add: eachPlayerList].
	self teamsRow: Me5Row new.
	TournamentPlannerApp collectionOfTeams data do: [ :eachTeam | 
		theTeamMemberDiv := Me5Div new.
		eachTeam members do: [ :eachPlayer |
			theTeamMemberDiv addChild: (Me5Div new
			addChild: (Me5P new
			text: eachPlayer asString;
			fontSize: 'large';
			yourself))].		
		self teamsRow addChild: (theTeamDiv := Me5Div new
			padding: 15;
			addCssClassColSm12;
			addCssClassColMd6;
			addCssClassColXl4;
			addChild: (Me5Portlet newPrimary
				title: eachTeam teamName;
				addChildToHeadTools: (Me5A newIconOnlyPrimary
					icon: Me5I newFasTrash;
					componentObject: eachTeam teamName;
					addClickEventSelector: #yesNoModalRemoveTeam: eventReceiver: self;
					yourself);
				addChildToBody: theTeamMemberDiv;
				yourself);
			yourself).
		self dictionaryOfTeamDivs add: (Association new
			key: eachTeam teamName value: theTeamDiv)].
	theResultDiv := Me5Div new 
		addChild: (Me5H1 new 
			text: 'Teams';
			addCssClassTextCenter;
			yourself);
		addChild: Me5Hr new;
		addChild: (Me5Accordion new
			addChild: (Me5AccordionItem new
				icon: Me5I newFasEdit;
				title: 'Team erstellen';
				addChildToContent: (Me5Form new
					addChildToBody: (textFieldTeamName := Me5TextField new
						text: 'Neues Team';
						placeholder: 'Teamname';
						yourself);
					addChildToBody: (multiComboBoxTeamMembers := Me5Select2MultiSelectBox new
						text: 'Teammitglieder';
						objects: thePersons;
						placeholder: 'Personen';
						yourself);
					addChildToActions: (Me5Button newSuccess
						text: 'Speichern';
						icon: Me5I newFasSave;
						addClickEventSelector: #newTeamClicked eventReceiver: self;
						yourself);
					yourself);
				yourself);
			yourself);
		addChild: self teamsRow;
		yourself.
	self modalTextFieldTeamName: textFieldTeamName.
	self modalMultiComboBoxTeamMembers: multiComboBoxTeamMembers.
	self addChild: theResultDiv
	
]

{ #category : 'Accessing' }
ManageTeamsView >> dictionaryOfTeamDivs [

	"<^hOf Dictionary: {key: iOf String, value: iOf Me5Div}>"
	"Answer the dictionaryOfTeamDivs of the receiver"

	^dictionaryOfTeamDivs
]

{ #category : 'Accessing' }
ManageTeamsView >> dictionaryOfTeamDivs: aDictionary [

	"<aDictionary: hOf Dictionary: {key: iOf String, value: iOf Me5Div}, ^self>"
	"Set the dictionaryOfTeamDivs of the receiver"

	dictionaryOfTeamDivs := aDictionary
]

{ #category : 'Accessing' }
ManageTeamsView >> modalMultiComboBoxTeamMembers [

	"<^iOf Me5MultiComboBox>"
	"Answer the modalMultiComboBoxTeamMembers of the receiver"

	^modalMultiComboBoxTeamMembers
]

{ #category : 'Accessing' }
ManageTeamsView >> modalMultiComboBoxTeamMembers: aMe5MultiComboBox [

	"<aMe5MultiComboBox: iOf Me5MultiComboBox, ^self>"
	"Set the modalMultiComboBoxTeamMembers of the receiver"

	modalMultiComboBoxTeamMembers := aMe5MultiComboBox
]

{ #category : 'Accessing' }
ManageTeamsView >> modalTextFieldTeamName [

	"<^iOf Me5TextField>"
	"Answer the modalTextFieldTeamName of the receiver"

	^modalTextFieldTeamName
]

{ #category : 'Accessing' }
ManageTeamsView >> modalTextFieldTeamName: aMe5TextField [

	"<aMe5TextField: iOf Me5TextField, ^self>"
	"Set the modalTextFieldTeamName of the receiver"

	modalTextFieldTeamName := aMe5TextField
]

{ #category : 'Events' }
ManageTeamsView >> newTeamClicked [
	
	"<^self>"
	"creates new Team"
	
	| theSingleTeamDiv theTeamMembers theTeam theExistingTeam theTeamDiv theSelectedObjects |
	
	theSelectedObjects := self modalMultiComboBoxTeamMembers selectedObjects.
	theTeamMembers := OrderedCollection new.
	theSingleTeamDiv := Me5Div new.	
	self modalTextFieldTeamName clearErrorText.
	self modalMultiComboBoxTeamMembers clearErrorText.	
	self modalTextFieldTeamName value = ''
		ifTrue: [self modalTextFieldTeamName setErrorText: 'Team hat keinen Namen'].	
	self modalMultiComboBoxTeamMembers selectedObjects size<=0
		ifTrue: [self modalMultiComboBoxTeamMembers setErrorText: 'Team hat zu wenig Mitglieder'].	
	theExistingTeam := TournamentPlannerApp collectionOfTeams data detect: [ :eachTeam |
		eachTeam teamName = self modalTextFieldTeamName value] ifNone: [nil].
	theExistingTeam
		ifNil: [
			(self modalMultiComboBoxTeamMembers hasErrorStyle not and: [self modalTextFieldTeamName hasErrorStyle not])
				ifTrue: [
					self modalMultiComboBoxTeamMembers value do: [ :eachValue | 	
						theTeamMembers add: eachValue.
						theSingleTeamDiv addChild: (Me5P new 
							text: eachValue;
							fontSize: 'large';
							yourself)].
					self teamsRow addChild: (theTeamDiv := Me5Div new
						addChild: (Me5Portlet newPrimary
							title: self modalTextFieldTeamName value;
							addChildToHeadTools: (Me5A newIconOnlyPrimary
								icon: Me5I newFasTrash;
								componentObject: self modalTextFieldTeamName value;
								addClickEventSelector: #yesNoModalRemoveTeam: eventReceiver: self;
								yourself);
							addChildToBody: theSingleTeamDiv;
							yourself);
						padding: 15;
						addCssClassColSm12;
						addCssClassColMd6;
						addCssClassColXl4;
						yourself).
					self dictionaryOfTeamDivs add: (Association new
						key: self modalTextFieldTeamName value value: theTeamDiv).
					theTeam := Team newWithTeamName: (self modalTextFieldTeamName value ) players: theTeamMembers.
					TournamentPlannerApp collectionOfTeams data add: theTeam.					
					TournamentPlannerApp saveCollectionOfTeams: (TournamentPlannerApp collectionOfTeams data).
					self modalTextFieldTeamName value: ''.
					theSelectedObjects do: [ :eachMember |
						self modalMultiComboBoxTeamMembers deselectObject: eachMember].
					self showSuccessNotificationWithMessage: ('Team %1 wurde erstellt!' bindWith: theTeam asString)
					]]
		ifNotNil: [self modalTextFieldTeamName setErrorText: ('Das Team exisistiert bereits')]
]

{ #category : 'Events' }
ManageTeamsView >> removeTeam: aMe5DialogEvent [

	"<^self>"
	"removes Team"

	| theDivTeam theTeam |
	
	theDivTeam := self dictionaryOfTeamDivs at: self teamToDelete ifAbsent: [^self showErrorNotificationWithMessage: 'Team wurde nicht gefunden!'].	
	theDivTeam removeComponent.	
	theTeam := TournamentPlannerApp collectionOfTeams data detect: [ :eachTeam |
		eachTeam teamName = self teamToDelete] ifNone: [].
	TournamentPlannerApp collectionOfTeams data remove: theTeam ifAbsent: [^self showErrorNotificationWithMessage: 'Team wurde nicht gefunden!'].
	TournamentPlannerApp saveCollectionOfTeams: TournamentPlannerApp collectionOfTeams data.
	self dictionaryOfTeamDivs removeKey: self teamToDelete ifAbsent: [^self showErrorNotificationWithMessage: 'Team wurde nicht gefunden!'].
	self showSuccessNotificationWithMessage: ('Team %1 gel&ouml;scht' bindWith: theTeam asString)
]

{ #category : 'Accessing' }
ManageTeamsView >> teamsRow [

	"<^iOf Me5Div>"
	"Answer the teamsRow of the receiver"

	^teamsRow
]

{ #category : 'Accessing' }
ManageTeamsView >> teamsRow: aMe5Div [

	"<aMe5Div: iOf Me5Div, ^self>"
	"Set the teamsRow of the receiver"

	teamsRow := aMe5Div
]

{ #category : 'Accessing' }
ManageTeamsView >> teamToDelete [

	"<^iOf String>"
	"Answer the teamToDelete of the receiver"

	^teamToDelete
]

{ #category : 'Accessing' }
ManageTeamsView >> teamToDelete: aString [

	"<aString: iOf String, ^self>"
	"Set the teamToDelete of the receiver"

	teamToDelete := aString
]

{ #category : 'Events' }
ManageTeamsView >> yesNoModalRemoveTeam: aMe5Event [

	"<^self>"
	self tournamentToDelete: aMe5Event component componentObject.
	self showYesNoDialogWithTitle: 'Team l&ouml;schen?' message: '' yesSelector: #removeTeam:
]
