--Team
DROP TABLE IF EXISTS [dbo].[team]
GO
CREATE TABLE [dbo].[team] (
	[ID] 					INT IDENTITY (1,1)			NOT NULL,
	[productID]				INT 						NOT NULL
);

ALTER TABLE
	[dbo].[team]
ADD 
	CONSTRAINT [PK_teams] PRIMARY KEY CLUSTERED ([ID] ASC);

--Employee
DROP TABLE IF EXISTS [dbo].[employee]
GO
CREATE TABLE [dbo].[employee] (
	[ID]					INT 						NOT NULL,
	[teamID]				INT 						NOT NULL,
	[name]					VARCHAR						NOT NULL,
	[email]					VARCHAR						NOT NULL
);

ALTER TABLE
	[dbo].[employee]
ADD
	CONSTRAINT [PK_employees] PRIMARY KEY CLUSTERED ([ID] ASC);

--Product Manager
DROP TABLE IF EXISTS [dbo].[productManager]
GO
CREATE TABLE [dbo].[productManager] (
	[ID]					INT 						NOT NULL,
	[name]					VARCHAR						NOT NULL,
	[teamID]				INT 						NOT NULL
);

ALTER TABLE
	[dbo].[productManager]
ADD
	CONSTRAINT [PK_productManager] PRIMARY KEY CLUSTERED ([ID] ASC);

--PM Ticket
DROP TABLE IF EXISTS [dbo].[pmTickets]
GO
CREATE TABLE [dbo].[pmTickets] (
	[ID]					INT 						NOT NULL,
	[productManagerID]		INT 						NOT NULL,
	[ticketID]				INT 						NOT NULL
);

ALTER TABLE
	[dbo].[pmTickets]
ADD
	CONSTRAINT [PK_pmTickets] PRIMARY KEY CLUSTERED ([ID] ASC);

--Features
DROP TABLE IF EXISTS [dbo].[features]
GO
CREATE TABLE [dbo].[features] (
	[ID]					INT 						NOT NULL,
	[releaseDate]			DATE 						NOT NULL,
	[deprecated]			TINYINT						NOT NULL,
	[parentID]				INT 						NOT NULL,
	[description]			TEXT						NULL,
	[depeartment]			VARCHAR						NOT NULL,
	[name]					VARCHAR						NOT NULL
);

ALTER TABLE
	[dbo].[features]
ADD
	CONSTRAINT [PK_features] PRIMARY KEY CLUSTERED ([ID] ASC);

--Product
DROP TABLE IF EXISTS [dbo].[product]
GO 
CREATE TABLE [dbo].[product] (
	[ID]					INT 						NOT NULL,
	[productVersion]		INT 						NOT NULL,
	[releaseDate]			DATE 						NOT NULL,
	[approved]				TINYINT						NOT NULL,
	[projectManagerID]		INT 						NOT NULL
);

ALTER TABLE
	[dbo].[product]
ADD
	CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED ([ID] ASC);

--Release Scope
DROP TABLE IF EXISTS [dbo].[releaseScope]
GO
CREATE TABLE [dbo].[releaseScope] (
	[ID]					INT 						NOT NULL,
	[productID]				INT 						NOT NULL,
	[releaseScopeVersion]	INT 						NOT NULL,
	[featureID]				INT 						NOT NULL
);

ALTER TABLE
	[dbo].[releaseScope]
ADD
	CONSTRAINT [PK_releaseScope] PRIMARY KEY CLUSTERED ([ID] ASC);

--Ticket
DROP TABLE IF EXISTS [dbo].[ticket]
GO
CREATE TABLE [dbo].[ticket] (
	[ID]					INT 						NOT NULL,
	[type]					VARCHAR	 					NOT NULL,
	[productManagerID]		INT 						NOT NULL,
	[priority]				INT 						NOT NULL,
	[approved]				TINYINT 					NOT NULL,
	[description]			TEXT						NULL,
	[state]					VARCHAR						NOT NULL,
	[ticketCreationDate]	DATETIME					NOT NULL,
	[parentID]				INT 						NOT NULL,
	[featureID]				INT 						NOT NULL
);

ALTER TABLE
	[dbo].[ticket]
ADD
	CONSTRAINT [PK_ticket] PRIMARY KEY CLUSTERED ([ID] ASC);

--PMS
DROP TABLE IF EXISTS [dbo].[pms]
GO
CREATE TABLE [dbo].[pms] (
	[ID] 					INT 						NOT NULL,
	[projectID]				INT 						NOT NULL,
	[productName] 			VARCHAR 					NOT NULL
);

ALTER TABLE
	[dbo].[pms]
ADD
	CONSTRAINT [PK_pms] PRIMARY KEY CLUSTERED ([ID] ASC);

--Product Log
DROP TABLE IF EXISTS [dbo].[productLog]
GO
CREATE TABLE [dbo].[productLog] (
	[ID]					INT 						NOT NULL,
	[ticketID]				INT 						NOT NULL,
	[acceptedBy]			VARCHAR						NOT NULL,
	[acceptedDate]			DATE 						NOT NULL
);

ALTER TABLE
	[dbo].[productLog]
ADD
	CONSTRAINT [PK_productLog] PRIMARY KEY CLUSTERED ([ID] ASC);

--Comment
DROP TABLE IF EXISTS [dbo].[comment]
GO
CREATE TABLE [dbo].[comment] (
	[ID]					INT 						NOT NULL,
	[ticketID]				INT 						NOT NULL,
	[comment]				TEXT 						NOT NULL
);

ALTER TABLE
	[dbo].[comment]
ADD
	CONSTRAINT [PK_comment] PRIMARY KEY CLUSTERED ([ID] ASC);

ALTER TABLE
    [dbo].[team]
ADD
    CONSTRAINT [FK_team_products] FOREIGN KEY ([product_id]) REFERENCES [dbo].[product]([id]);

ALTER TABLE
    [dbo].[employee]
ADD
    CONSTRAINT [FK_employee_teams] FOREIGN KEY ([team_id]) REFERENCES [dbo].[team]([id]);

ALTER TABLE
    [dbo].[product_manager]
ADD
    CONSTRAINT [FK_product_manager_teams] FOREIGN KEY ([team_id]) REFERENCES [dbo].[team]([id]);

ALTER TABLE
    [dbo].[product]
ADD
    CONSTRAINT [FK_product_product_managers] FOREIGN KEY ([product_manager_id]) REFERENCES [dbo].[product_manager]([id]);

ALTER TABLE
    [dbo].[release_scope]
ADD
    CONSTRAINT [FK_release_scope_products] FOREIGN KEY ([product_id]) REFERENCES [dbo].[product]([id]);
ALTER TABLE
    [dbo].[release_scope]
ADD
    CONSTRAINT [FK_release_scope_features] FOREIGN KEY ([feature_id]) REFERENCES [dbo].[feature]([id]);

ALTER TABLE
    [dbo].[product_log]
ADD
    CONSTRAINT [FK_product_log_tickets] FOREIGN KEY ([ticket_id]) REFERENCES [dbo].[ticket]([id]);

ALTER TABLE
    [dbo].[pms]
ADD
    CONSTRAINT [FK_pms_products] FOREIGN KEY ([product_id]) REFERENCES [dbo].[product]([id]);

ALTER TABLE
    [dbo].[ticket]
ADD
    CONSTRAINT [FK_ticket_features] FOREIGN KEY ([feature_id]) REFERENCES [dbo].[feature]([id]);
ALTER TABLE
    [dbo].[ticket]
ADD
    CONSTRAINT [FK_ticket_product_manager_id] FOREIGN KEY ([product_manager_id]) REFERENCES [dbo].[product_manager]([id]);
ALTER TABLE
    [dbo].[comment]
ADD
    CONSTRAINT [FK_comment_tickets] FOREIGN KEY ([ticket_id]) REFERENCES [dbo].[ticket]([id]);

ALTER TABLE
    [dbo].[pm_ticket]
ADD
    CONSTRAINT [FK_pm_ticket_product_managers] FOREIGN KEY ([product_manager_id]) REFERENCES [dbo].[product_manager]([id]);
ALTER TABLE
    [dbo].[pm_ticket]
ADD
    CONSTRAINT [FK_pm_ticket_tickets] FOREIGN KEY ([ticket_id]) REFERENCES [dbo].[ticket]([id])
