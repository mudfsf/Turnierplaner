Class {
	#name : 'UserSettingsView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'user',
		'playerCombobox',
		'inputFirstName',
		'inputLastName',
		'inputEmail'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
UserSettingsView >> createComponents [

	"<^self>"
	"Sends the userSettings Tab to the receiver"

	(TournamentPlannerApp loggedInUser isNil)
		ifTrue: [TournamentPlannerApp loggedInUser: TournamentPlannerApp collectionOfPlayers data first].
	self user: TournamentPlannerApp loggedInUser.	
	self inputFirstName: (Me5TextField new
		text: 'Vorname';
		value: self user firstName;
		placeholder: 'Vorname';
		addCssClassCol12;
		addCssClassColLg6;
		yourself).
	self inputLastName: (Me5TextField new
		text: 'Nachname';
		value: self user lastName;
		placeholder: 'Nachname';
		addCssClassColLg6;
		addCssClassCol12;
		yourself).
	self inputEmail: (Me5TextField new
		text: 'E-Mail';
		value: self user email;
		placeholder: 'E-Mail';
		addCssClassColLg6;
		addCssClassCol12;
		yourself).
	self playerCombobox: (Me5SelectBox new
		text: 'Benutzer ausw&auml;hlen';			
		objects: (TournamentPlannerApp collectionOfPlayers data collect: [ :eachPlayer |
			eachPlayer asString]);
		selectedObject: self user asString;
		addChangeEventSelector: #userSelectedEvent eventReceiver: self;
		addCssClassColLg6;
		addCssClassCol12;
		yourself).	
	self 
		addChild: (Me5Div new
			addChild: (Me5H1 new 
				text: 'Einstellungen';
				addCssClassTextCenter;
				yourself);
			addChild: Me5Hr new;
			addChild: (Me5Form new
				addChildToBody: (Me5Row new
					addChild: self inputFirstName;
					addChild: self inputLastName;
					addChild: self inputEmail;
					addChild: (Me5PasswordField new
						text: 'Passwort';
						placeholder: 'Passwort';
						addCssClassColLg6;
						addCssClassCol12;
						yourself);
					addChild: self playerCombobox;
					yourself);
				addChildToRow: (Me5Button newSuccess
					text: 'Speichern';
					icon: Me5I newFasSave;
					addClickEventSelector: #savePlayer eventReceiver: self;
					yourself);
				yourself);
			yourself)
]

{ #category : 'Accessing' }
UserSettingsView >> inputEmail [

	"<^iOf Me5TextField>"
	"Answer the inputEmail of the receiver"

	^inputEmail
]

{ #category : 'Accessing' }
UserSettingsView >> inputEmail: aMe5TextField [

	"<aMe5TextField: iOf Me5TextField, ^self>"
	"Set the inputEmail of the receiver"

	inputEmail := aMe5TextField
]

{ #category : 'Accessing' }
UserSettingsView >> inputFirstName [

	"<^iOf Me5TextField>"
	"Answer the inputFirstName of the receiver"

	^inputFirstName
]

{ #category : 'Accessing' }
UserSettingsView >> inputFirstName: aMe5TextField [

	"<aMe5TextField: iOf Me5TextField, ^self>"
	"Set the inputFirstName of the receiver"

	inputFirstName := aMe5TextField
]

{ #category : 'Accessing' }
UserSettingsView >> inputLastName [

	"<^iOf Me5TextField>"
	"Answer the inputLastName of the receiver"

	^inputLastName
]

{ #category : 'Accessing' }
UserSettingsView >> inputLastName: aMe5TextField [

	"<aMe5TextField: iOf Me5TextField, ^self>"
	"Set the inputLastName of the receiver"

	inputLastName := aMe5TextField
]

{ #category : 'Accessing' }
UserSettingsView >> playerCombobox [

	"<^iOf Me5Combobox>"
	"Answer the playerCombobox of the receiver"

	^playerCombobox
]

{ #category : 'Accessing' }
UserSettingsView >> playerCombobox: aMe5Combobox [

	"<aMe5Combobox: iOf Me5Combobox, ^self>"
	"Set the playerCombobox of the receiver"

	playerCombobox := aMe5Combobox
]

{ #category : 'Events' }
UserSettingsView >> savePlayer [

	"<^self>"
	"Change the attributes of the logged in player"
	
	self inputFirstName clearErrorText.
	self inputLastName clearErrorText.
	self inputEmail clearErrorText.	
	self inputFirstName value isEmpty
		ifTrue: [self inputFirstName setErrorText: 'Bitte Vornamen eingeben.'].
	self inputLastName value isEmpty
		ifTrue: [self inputLastName setErrorText: 'Bitte Nachnamen eingeben.'].
	self inputEmail value isEmpty
		ifTrue: [self inputEmail setErrorText: 'Bitte Email eingeben.'].
	((self inputFirstName hasErrorStyle or: [self inputLastName hasErrorStyle]) or: [self inputEmail hasErrorStyle])
		ifTrue: [^self].
	TournamentPlannerApp loggedInUser firstName: self inputFirstName value.
	TournamentPlannerApp loggedInUser lastName: self inputLastName value.
	TournamentPlannerApp loggedInUser email: self inputEmail value.
	TournamentPlannerApp saveCollectionOfPlayers: TournamentPlannerApp collectionOfPlayers data.
	self reloadViewBySourceView: self.
	self showSuccessNotificationWithMessage: 'Daten erfolgreich gespeichert.'
]

{ #category : 'Accessing' }
UserSettingsView >> user [

	"<^iOf Player>"
	"Answer the user of the receiver"

	^user
]

{ #category : 'Accessing' }
UserSettingsView >> user: aPlayer [

	"<aPlayer: iOf Player, ^self>"
	"Set the user of the receiver"

	user := aPlayer
]

{ #category : 'Events' }
UserSettingsView >> userSelectedEvent [

	"^self"
	"Saves the selected player into the logged-in User. This is only used before the log-in is implemented"
	
	| theUsername thePlayer |
	
	theUsername := self playerCombobox selectedObject.
	
	thePlayer := TournamentPlannerApp collectionOfPlayers data at: (TournamentPlannerApp collectionOfPlayers data findFirst: [ :eachPlayer |
		eachPlayer asString = theUsername]) ifAbsent: [ self showErrorNotificationWithMessage: 'Ein Fehler ist aufgetreten, bitte die Seite neuladen'. ^self].

	self user: thePlayer.
	TournamentPlannerApp loggedInUser: thePlayer.
	
	self showSuccessNotificationWithMessage: ('Eingeloggter Benutzer: %1' bindWith: thePlayer asString).
	self reloadViewBySourceView: self
]
