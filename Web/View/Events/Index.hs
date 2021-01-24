module Web.View.Events.Index where
import Web.View.Prelude

data IndexView = IndexView { events :: [Event] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={EventsAction}>Events</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewEventAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Event</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach events renderEvent}</tbody>
            </table>
        </div>
    |]


renderEvent event = [hsx|
    <tr>
        <td>{event}</td>
        <td><a href={ShowEventAction (get #id event)}>Show</a></td>
        <td><a href={EditEventAction (get #id event)} class="text-muted">Edit</a></td>
        <td><a href={DeleteEventAction (get #id event)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
