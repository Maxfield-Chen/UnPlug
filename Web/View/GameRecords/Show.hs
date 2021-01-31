module Web.View.GameRecords.Show where
import Web.View.Prelude

data ShowView = ShowView { gameRecord :: Include "users" GameRecord, users :: [User] }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={GameRecordsAction}>GameRecords</a></li>
                <li class="breadcrumb-item active">Show GameRecord</li>
            </ol>
        </nav>
        <h1>Win Conditions</h1>
          <ul class="list-group list-group-horizontal">
            <li class="list-group-item">Prose: { get #proseWinThreshold gameRecord}</li>
            <li class="list-group-item">Assistance: { get #assistanceWinThreshold gameRecord}</li>
            <li class="list-group-item">Social: { get #socialWinThreshold gameRecord}</li>
          </ul>
        <h1>Users</h1>
        <div>{ forEach (get #users gameRecord) renderUser}</div>
        { renderUserList users }
    |]

renderUser user = [hsx|
    <div class="card" style="width: 18rem;">
      <img src="..." class="card-img-top" alt="...">
      <div class="card-body">
        <h5 class="card-title">{ get #email user}</h5>
        <p class="card-text">
          <ul class="list-group list-group-flush">
            <li class="list-group-item">Prose: { get #prosePoints user}</li>
            <li class="list-group-item">Assistance: { get #assistancePoints user}</li>
            <li class="list-group-item">Social: {get #socialPoints user}</li>
          </ul>
        </p>
      </div>
    </div>|]


renderUserList users = [hsx|
    <p>
          <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#userList" aria-expanded="false" aria-controls="userList">
      Add User To Game
  </button>
    </p>
    <div class="collapse" id="userList">
        { forEach users addUser}
    </div>
|]

addUser user = formFor' user "UpdateUser" [hsx|
      <div class="card card-body">
        <p>UserName: {get #email user}</p>
        { hiddenField #id }
        { hiddenField #currentGame }
        {submitButton { label = "Add to Game"}}
      </div>
|]
