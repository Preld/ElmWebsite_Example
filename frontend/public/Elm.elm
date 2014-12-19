import Color
import Graphics.Element (..)
import Markdown
import Signal (Signal, (<~))
import Text
import Website.Widgets (bigLogo, installButtons, button)
import Website.Skeleton (skeleton)
import Website.BigTiles as Tile
import Website.ColorScheme as C
import Window

port title : String
port title = "HaruNire - Elmで遊ぶ"

main = skeleton "" content <~ Window.dimensions

tagLine =
    Text.leftAligned <|
        --Text.fromString "A " ++
        --Text.link "/learn/What-is-FRP.elm" (Text.fromString "functional reactive") ++
        Text.fromString "関数型リアクティブ言語Elmで遊ぶ"

content outer =
    let inner = 600
        half = inner // 2
        center elem =
            container outer (heightOf elem) middle elem
        centerText msg =
            let msg' = width inner msg
            in  center msg'
    in
    color Color.white (flow down
    [ spacer outer 20
    , container outer 100 middle bigLogo
    , container outer 40 middle tagLine
    , center (installButtons 440)
    , spacer outer 20
    ]) `above` flow down
    [ color C.mediumGrey (spacer outer 1)
    , spacer outer 30
    , center threeKeywords
    , spacer outer 60
    , centerText exampleText
    , container outer 500 middle <| exampleBlock 860
    , center (button outer 260 "/Examples.elm" "More Examples")
    , spacer outer 60
    , width outer debuggerTitle
    , centerText debuggerText
    , center debuggerBlock
    , center <| flow right
        [ button 220 180 "/try" "Edit"
        , button 220 180 "http://debug.elm-lang.org/try" "Debug"
        ]
    ]

threeKeywords =
    flow right
    [ width 260 functional
    , spacer 40 10
    , width 260 reactive
    , spacer 40 10
    , width 260 compatible
    ]

functional = Markdown.toElement """
<div style="font-family: futura, 'century gothic', 'twentieth century', calibri, verdana, helvetica, arial; text-align: center; font-size: 2em;">Functional</div>

Features like immutability and type inference help you write code that is short,
fast, and maintainable. Elm makes them [easy to learn](/Learn.elm) too.

"""

reactive = Markdown.toElement """
<div style="font-family: futura, 'century gothic', 'twentieth century', calibri, verdana, helvetica, arial; text-align: center; font-size: 2em;">Reactive</div>

Elm is based on the idea of [Functional Reactive
Programming](/learn/What-is-FRP.elm). Create highly interactive applications
without messy callbacks or a tangle of shared state.
"""

compatible = Markdown.toElement """
<div style="font-family: futura, 'century gothic', 'twentieth century', calibri, verdana, helvetica, arial; text-align: center; font-size: 2em;">Compatible</div>

Elm compiles to HTML, CSS, and JavaScript. It is easy to [use HTML][html] and
[interop with JS][ports], so it is simple to write part of your application in Elm.

[html]: /blog/Blazing-Fast-Html.elm
[ports]: /learn/Ports.elm

"""

exampleText = Markdown.toElement """

<div style="font-family: futura, 'century gothic', 'twentieth century', calibri, verdana, helvetica, arial; text-align: center; font-size: 3em;">Examples</div>

Elm is great for [2D](/blog/Pong.elm) and
[3D](https://github.com/johnpmayer/elm-webgl) games,
[diagrams](https://github.com/seliopou/elm-d3), widgets, and
[websites](/blog/Blazing-Fast-Html.elm). In addition to the larger
examples showcased here, there are tons of [educational examples](/Examples.elm)
to help you learn Elm by reading and modifying simple programs.

"""

exampleBlock w =
    Tile.examples w
    [ [ ("Home/Mario", "/edit/examples/Intermediate/Mario.elm", Nothing)
      , ("Home/Elmtris", "http://people.cs.umass.edu/~jcollard/elmtris/", Just "https://github.com/jcollard/elmtris")
      , ("Home/Vessel", "https://slawrence.github.io/vessel", Just "https://github.com/slawrence/vessel")
      , ("Home/FirstPerson", "https://evancz.github.io/first-person-elm", Just "https://github.com/evancz/first-person-elm")
      ]
    , [ ("Home/Todo", "https://evancz.github.io/elm-todomvc", Just "https://github.com/evancz/elm-todomvc")
      , ("Home/DreamWriter", "http://dreamwriter.io", Just "https://github.com/rtfeldman/dreamwriter")
      , ("Home/Catalog", "http://package.elm-lang.org/packages/elm-lang/core/latest", Just "https://github.com/elm-lang/elm-get/tree/master/website")
      , ("Home/Fractal", "http://gideon.smdng.nl/2014/04/fractals-for-fun-and-profit/", Nothing)
      ]
    ]

debuggerTitle = Markdown.toElement """

<div style="font-family: futura, 'century gothic', 'twentieth century', calibri, verdana, helvetica, arial; text-align: center; font-size: 3em;">Time Traveling Debugger</div>

"""

debuggerText = Markdown.toElement """

Elm's [Time Traveling Debugger][debug] makes debugging and exploration easy.
It also allows [hot-swapping](/blog/Interactive-Programming.elm), so you
can modify running programs. [Elm Reactor][reactor] bundles up all these
features for use with your favorite code editor.

[debug]: http://debug.elm-lang.org
[reactor]: /blog/Introducing-Elm-Reactor.elm

"""

debuggerBlock =
    Tile.example (860,260) ("Home/Debugger", "/blog/Introducing-Elm-Reactor.elm", Nothing)
