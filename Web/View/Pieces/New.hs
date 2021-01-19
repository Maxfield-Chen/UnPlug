module Web.View.Pieces.New where
import Web.View.Prelude

data NewView = NewView { piece :: Piece }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PiecesAction}>Pieces</a></li>
                <li class="breadcrumb-item active">New Piece</li>
            </ol>
        </nav>
        <h1>New Piece</h1>
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
