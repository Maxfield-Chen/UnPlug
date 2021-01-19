module Web.FrontController where

import IHP.AutoRefresh
import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.GameRecords
import Web.Controller.Users
import Web.Controller.Pieces
import Web.Controller.Static

instance FrontController WebApplication where
    controllers = 
        [ startPage WelcomeAction
        -- Generator Marker
        , parseRoute @GameRecordsController
        , parseRoute @UsersController
        , parseRoute @PiecesController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh