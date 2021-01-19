module Web.View.Pieces.Show where
import Web.View.Prelude

data ShowView = ShowView { piece :: Piece }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PiecesAction}>Pieces</a></li>
                <li class="breadcrumb-item active">Show Piece</li>
            </ol>
        </nav>
        <h1>Show Piece</h1>
        <p>{piece}</p>
    |]
