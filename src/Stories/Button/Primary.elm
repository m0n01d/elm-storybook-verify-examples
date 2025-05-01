module Stories.Button.Primary exposing (..)




import Ui.Button exposing (..)
import Ui.Button
import Storybook.Story exposing (Story)
import Html exposing (Html)

type Msg
    = UserClickedSignUp

main : Story () Msg
main =
    Storybook.Story.stateless
        { view = view
        }
view : Html Msg
view =
    Ui.Button.new { label = "Sign up" }
        |> Ui.Button.onClick UserClickedSignUp
        |> Ui.Button.view
