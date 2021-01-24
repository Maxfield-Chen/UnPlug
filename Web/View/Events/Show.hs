module Web.View.Events.Show where
import Web.View.Prelude

data ShowView = ShowView { event :: Event }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={EventsAction}>Events</a></li>
                <li class="breadcrumb-item active">Show Event</li>
            </ol>
        </nav>
        <h1>Show Event</h1>
        <p>{event}</p>
    |]
