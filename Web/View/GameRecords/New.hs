module Web.View.GameRecords.New where
import Web.View.Prelude

data NewView = NewView { gameRecord :: GameRecord }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={GameRecordsAction}>GameRecords</a></li>
                <li class="breadcrumb-item active">New GameRecord</li>
            </ol>
        </nav>
        <h1>New GameRecord</h1>
        {renderForm gameRecord}
    |]

renderForm :: GameRecord -> Html
renderForm gameRecord = formFor gameRecord [hsx|
    {submitButton}
|]
