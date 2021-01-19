module Web.Controller.Pieces where

import Web.Controller.Prelude
import Web.View.Pieces.Index
import Web.View.Pieces.New
import Web.View.Pieces.Edit
import Web.View.Pieces.Show

instance Controller PiecesController where
    action PiecesAction = do
        pieces <- query @Piece |> fetch
        render IndexView { .. }

    action NewPieceAction = do
        let piece = newRecord
        render NewView { .. }

    action ShowPieceAction { pieceId } = do
        piece <- fetch pieceId
        render ShowView { .. }

    action EditPieceAction { pieceId } = do
        piece <- fetch pieceId
        render EditView { .. }

    action UpdatePieceAction { pieceId } = do
        piece <- fetch pieceId
        piece
            |> buildPiece
            |> ifValid \case
                Left piece -> render EditView { .. }
                Right piece -> do
                    piece <- piece |> updateRecord
                    setSuccessMessage "Piece updated"
                    redirectTo EditPieceAction { .. }

    action CreatePieceAction = do
        let piece = newRecord @Piece
        piece
            |> buildPiece
            |> ifValid \case
                Left piece -> render NewView { .. } 
                Right piece -> do
                    piece <- piece |> createRecord
                    setSuccessMessage "Piece created"
                    redirectTo PiecesAction

    action DeletePieceAction { pieceId } = do
        piece <- fetch pieceId
        deleteRecord piece
        setSuccessMessage "Piece deleted"
        redirectTo PiecesAction

buildPiece piece = piece
    |> fill @["pieceType","x","y","gameRecordId","ownerId"]
