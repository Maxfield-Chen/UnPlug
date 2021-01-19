module Web.Controller.Sessions where

import Web.Controller.Prelude
import Web.View.Sessions.New
import qualified IHP.AuthSupport.Controller.Sessions as Sessions

instance Controller SessionsController where
  action NewSessionAction = Sessions.newSessionAction @User
  action DeleteSessionAction = Sessions.deleteSessionAction @User
  action CreateSessionAction = Sessions.createSessionAction @User

instance Sessions.SessionsControllerConfig User
