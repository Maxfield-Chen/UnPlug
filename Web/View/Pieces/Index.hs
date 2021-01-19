module Web.View.Pieces.Index where
import Web.View.Prelude

data IndexView = IndexView { pieces :: [Piece] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={PiecesAction}>Pieces</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewPieceAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Piece</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach pieces renderPiece}</tbody>
            </table>
        </div>
    |]


renderPiece piece = [hsx|
    <tr>
        <td>{piece}</td>
        <td><a href={ShowPieceAction (get #id piece)}>Show</a></td>
        <td><a href={EditPieceAction (get #id piece)} class="text-muted">Edit</a></td>
        <td><a href={DeletePieceAction (get #id piece)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
