module Web.View.Events.New where
import Web.View.Prelude

data NewView = NewView { event :: Event }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={EventsAction}>Events</a></li>
                <li class="breadcrumb-item active">New Event</li>
            </ol>
        </nav>
        <h1>New Event</h1>
        {renderForm event}
    |]

renderForm :: Event -> Html
renderForm event = formFor event [hsx|
    {(textField #eventType)}
    {(textField #game)}
    -- if anything is added to database since the controller autogen, we would need to update the connection here
    {submitButton}
|]
