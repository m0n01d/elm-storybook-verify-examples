module Ui.Button exposing
    ( Settings, new
    , withSecondaryStyle, withDangerStyle
    , withDisabledIf
    , Internals
    , onClick
    , view
    )

{-|

@docs Settings, new

@docs withSecondaryStyle, withDangerStyle
@docs withDisabledIf
@docs onClick

@docs view
@docs Internals
@docs story

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events



-- NEW


{-| Keeps track of the configuration settings.
-}
type Settings msg
    = Settings (Internals msg)



{-| Create a new button, with the default primary style
-}
new : { label : String } -> Settings msg
new options =
    Settings
        { label = options.label
        , style = Primary
        , onClick = Nothing
        , isDisabled = False
        }



-- MODIFIERS


{-| Modify a button to use the "secondary" style
-}
withSecondaryStyle : Settings msg -> Settings msg
withSecondaryStyle (Settings internals) =
    Settings { internals | style = Secondary }


{-| Modify a button to use the "danger" style
-}
withDangerStyle : Settings msg -> Settings msg
withDangerStyle (Settings internals) =
    Settings { internals | style = Danger }


{-| Conditionally show a button in the disabled state
-}
withDisabledIf : Bool -> Settings msg -> Settings msg
withDisabledIf isDisabled (Settings internals) =
    Settings { internals | isDisabled = isDisabled }


{-| Send a `msg` when a user clicks the button
@Storybook:Story:Control:Event
-}
onClick : msg -> Settings msg -> Settings msg
onClick msg (Settings internals) =
    Settings { internals | onClick = Just msg }



-- VIEW
{-| @Storybook:Story
    import Html exposing (Html)
    import Storybook.Story exposing (Story)
    import Ui.Button


    main : Story () Msg
    main =
        Storybook.Story.stateless
            { view = story
            }


    type Msg
        = UserClickedSignUp


    story : Html Msg
    story =
        Ui.Button.new { label = "Sign up" }
            |> Ui.Button.onClick UserClickedSignUp
            |> Ui.Button.view

    foobar = "baz"

    main
    --> main
-}
view : Settings msg -> Html msg
view (Settings internals) =
    Html.button
        [ Attr.classList
            [ ( "button", True )
            , ( "button--primary", internals.style == Primary )
            , ( "button--secondary", internals.style == Secondary )
            , ( "button--danger", internals.style == Danger )
            ]
        , Attr.disabled internals.isDisabled
        , case internals.onClick of
            Just msg ->
                Html.Events.onClick msg

            Nothing ->
                Attr.classList []
        ]
        [ Html.text internals.label
        ]



-- INTERNALS

{-| Internals docs here
-}
type alias Internals msg =
    { label : String
    , style : Style
    , onClick : Maybe msg
    , isDisabled : Bool
    }


type Style
    = Primary
    | Secondary
    | Danger
