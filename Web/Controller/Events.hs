module Web.Controller.Events where

import Web.Controller.Prelude
import Web.View.Events.Index
import Web.View.Events.New
import Web.View.Events.Edit
import Web.View.Events.Show

instance Controller EventsController where
    action EventsAction = do
        events <- query @Event |> fetch
        render IndexView { .. }

    action NewEventAction = do
        let event = newRecord
        render NewView { .. }

    action ShowEventAction { eventId } = do
        event <- fetch eventId
        render ShowView { .. }

    action EditEventAction { eventId } = do
        event <- fetch eventId
        render EditView { .. }

    action UpdateEventAction { eventId } = do
        event <- fetch eventId
        event
            |> buildEvent
            |> ifValid \case
                Left event -> render EditView { .. }
                Right event -> do
                    event <- event |> updateRecord
                    setSuccessMessage "Event updated"
                    redirectTo EditEventAction { .. }

    action CreateEventAction = do
        let event = newRecord @Event
        event
            |> buildEvent
            |> ifValid \case
                Left event -> render NewView { .. } 
                Right event -> do
                    event <- event |> createRecord
                    setSuccessMessage "Event created"
                    redirectTo EventsAction

    action DeleteEventAction { eventId } = do
        event <- fetch eventId
        deleteRecord event
        setSuccessMessage "Event deleted"
        redirectTo EventsAction

buildEvent event = event
    |> fill @["eventType","game"]
