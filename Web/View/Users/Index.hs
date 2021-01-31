module Web.View.Users.Index where
import Web.View.Prelude

data IndexView = IndexView { users :: [User] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a href={NewSessionAction}>Login</a>
            </li>
            <li class="breadcrumb-item">
              <a href={NewUserAction}>Register</a>
            </li>
            </ol>
        </nav>
        {forEach users renderUser}
    |]


renderUser user = [hsx|
    <tr>
        <td>{user}</td>
        <td><a href={ShowUserAction (get #id user)}>Show</a></td>
        <td><a href={EditUserAction (get #id user)} class="text-muted">Edit</a></td>
        <td><a href={DeleteUserAction (get #id user)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
