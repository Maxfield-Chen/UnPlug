module Web.Controller.GameRecords where

import Web.Controller.Prelude
import Web.View.GameRecords.Index
import Web.View.GameRecords.New
import Web.View.GameRecords.Edit
import Web.View.GameRecords.Show

instance Controller GameRecordsController where
    action GameRecordsAction = do
        gameRecords <- query @GameRecord |> fetch
        render IndexView { .. }

    action NewGameRecordAction {natureUserId, botUserId} = do
        let gameRecord = newRecord
        render NewView { .. }

    action ShowGameRecordAction { gameRecordId } = do
        gameRecord <- fetch gameRecordId
        render ShowView { .. }

    action EditGameRecordAction { gameRecordId } = do
        gameRecord <- fetch gameRecordId
        render EditView { .. }

    action UpdateGameRecordAction { gameRecordId } = do
        gameRecord <- fetch gameRecordId
        gameRecord
            |> ifValid \case
                Left gameRecord -> render EditView { .. }
                Right gameRecord -> do
                    gameRecord <- gameRecord |> updateRecord
                    setSuccessMessage "GameRecord updated"
                    redirectTo EditGameRecordAction { .. }

    action CreateGameRecordAction = do
        let gameRecord = newRecord @GameRecord
        gameRecord
            |> ifValid \case
                Left gameRecord -> render NewView { .. } 
                Right gameRecord -> do
                    gameRecord <- gameRecord |> createRecord
                    setSuccessMessage "GameRecord created"
                    redirectTo GameRecordsAction

    action DeleteGameRecordAction { gameRecordId } = do
        gameRecord <- fetch gameRecordId
        deleteRecord gameRecord
        setSuccessMessage "GameRecord deleted"
        redirectTo GameRecordsAction

-- buildGameRecord gameRecord = gameRecord
--     |> fill @["botUser", "natureUser"]
