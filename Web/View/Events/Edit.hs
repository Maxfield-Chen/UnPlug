module Web.View.Events.Edit where
import Web.View.Prelude

data EditView = EditView { event :: Event }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={EventsAction}>Events</a></li>
                <li class="breadcrumb-item active">Edit Event</li>
            </ol>
        </nav>
        <h1>Edit Event</h1>
        {renderForm event}
    |]

renderForm :: Event -> Html
renderForm event = formFor event [hsx|
    {(textField #eventType)}
    {(textField #game)}
    {submitButton}
|]
