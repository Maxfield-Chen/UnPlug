module Web.View.Pieces.Edit where
import Web.View.Prelude

data EditView = EditView { piece :: Piece }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PiecesAction}>Pieces</a></li>
                <li class="breadcrumb-item active">Edit Piece</li>
            </ol>
        </nav>
        <h1>Edit Piece</h1>
        {renderForm piece}
    |]

renderForm :: Piece -> Html
renderForm piece = formFor piece [hsx|
    {(textField #pieceType)}
    {(textField #x)}
    {(textField #y)}
    {(textField #gameRecordId)}
    {(textField #ownerId)}
    {submitButton}
|]
