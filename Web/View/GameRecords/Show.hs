module Web.View.GameRecords.Show where
import Web.View.Prelude

data ShowView = ShowView { gameRecord :: Include "users" GameRecord }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={GameRecordsAction}>GameRecords</a></li>
                <li class="breadcrumb-item active">Show GameRecord</li>
            </ol>
        </nav>
        <h1>GameRecord</h1>
        <p>{gameRecord}</p>
        <h1>Users</h1>
        <p>{get #users gameRecord}</p>
    |]
