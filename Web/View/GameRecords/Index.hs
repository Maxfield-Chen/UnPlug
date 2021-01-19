module Web.View.GameRecords.Index where
import Web.View.Prelude

data IndexView = IndexView { gameRecords :: [GameRecord] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={GameRecordsAction}>GameRecords</a></li>
            </ol>
        </nav>
        <h1>Index </h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>GameRecord</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach gameRecords renderGameRecord}</tbody>
            </table>
        </div>
    |]


renderGameRecord gameRecord = [hsx|
    <tr>
        <td>{gameRecord}</td>
        <td><a href={ShowGameRecordAction (get #id gameRecord)}>Show</a></td>
        <td><a href={EditGameRecordAction (get #id gameRecord)} class="text-muted">Edit</a></td>
        <td><a href={DeleteGameRecordAction (get #id gameRecord)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
