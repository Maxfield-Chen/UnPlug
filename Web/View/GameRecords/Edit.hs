module Web.View.GameRecords.Edit where
import Web.View.Prelude

data EditView = EditView { gameRecord :: GameRecord }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={GameRecordsAction}>GameRecords</a></li>
                <li class="breadcrumb-item active">Edit GameRecord</li>
            </ol>
        </nav>
        <h1>Edit GameRecord</h1>
        {renderForm gameRecord}
    |]

renderForm :: GameRecord -> Html
renderForm gameRecord = formFor gameRecord [hsx|
    {submitButton}
|]
