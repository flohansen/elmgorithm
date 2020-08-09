module Sort exposing (bubbleSort, insertionSort, keyFrames, mergeSort, quickSort)

import Types exposing (Item)


type alias KeyFrame comparable =
    List comparable


type alias SortOutput =
    { items : List Item
    , animation : List (KeyFrame Item)
    }


keyFrames : SortOutput -> List (KeyFrame Item)
keyFrames o =
    o.animation


insertionSort : List Item -> SortOutput
insertionSort list =
    insertionSortHelper list []


insertionSortHelper : List Item -> List Item -> SortOutput
insertionSortHelper list sorted =
    case list of
        [] ->
            SortOutput sorted [ sorted ]

        x :: xs ->
            let
                inserted =
                    insert x sorted xs

                insertedSorted =
                    insertionSortHelper xs inserted.items

                log =
                    inserted.animation
                        ++ insertedSorted.animation
            in
            SortOutput insertedSorted.items log


insert : Item -> List Item -> List Item -> SortOutput
insert x list rest =
    case list of
        y :: ys ->
            let
                indicatedX =
                    { x | color = "red" }

                indicatedY =
                    { y | color = "red" }
            in
            if x.value <= y.value then
                SortOutput (x :: y :: ys) [ rest ++ (indicatedX :: indicatedY :: ys) ]

            else
                let
                    inserted =
                        insert x ys (rest ++ [ y ])
                in
                SortOutput (y :: inserted.items) ((rest ++ indicatedX :: indicatedY :: ys) :: inserted.animation)

        [] ->
            SortOutput [ x ] [ rest ++ [ x ] ]


mergeSort : List Item -> SortOutput
mergeSort list =
    mergeSortHelper list [] []


mergeSortHelper : List Item -> List Item -> List Item -> SortOutput
mergeSortHelper list prevLeft prevRight =
    case list of
        [] ->
            SortOutput [] []

        [ x ] ->
            SortOutput list [ prevLeft ++ list ++ prevRight ]

        _ ->
            let
                ( left, right ) =
                    divideList list

                leftSorted =
                    mergeSortHelper left prevLeft (right ++ prevRight)

                rightSorted =
                    mergeSortHelper right (prevLeft ++ leftSorted.items) prevRight

                merged =
                    merge leftSorted.items rightSorted.items [] prevLeft prevRight

                log =
                    leftSorted.animation
                        ++ rightSorted.animation
                        ++ merged.animation
            in
            SortOutput merged.items log


divideList : List Item -> ( List Item, List Item )
divideList list =
    let
        numberLeft =
            List.length list // 2

        left =
            List.take numberLeft list

        right =
            List.drop numberLeft list
    in
    ( left, right )


merge : List Item -> List Item -> List Item -> List Item -> List Item -> SortOutput
merge left right sorted prevLeft prevRight =
    case left of
        [] ->
            SortOutput (sorted ++ right) [ prevLeft ++ sorted ++ right ++ prevRight ]

        x :: xs ->
            case right of
                [] ->
                    SortOutput (sorted ++ left) [ prevLeft ++ sorted ++ left ++ prevRight ]

                y :: ys ->
                    let
                        indicatedX =
                            { x | color = "red" }

                        indicatedY =
                            { y | color = "red" }
                    in
                    if x.value <= y.value then
                        let
                            merged =
                                merge xs right (sorted ++ [ x ]) prevLeft prevRight
                        in
                        SortOutput merged.items ([ prevLeft ++ sorted ++ [ indicatedX ] ++ xs ++ indicatedY :: ys ++ prevRight ] ++ merged.animation)

                    else
                        let
                            merged =
                                merge left ys (sorted ++ [ y ]) prevLeft prevRight
                        in
                        SortOutput merged.items ([ prevLeft ++ sorted ++ [ indicatedY ] ++ indicatedX :: xs ++ ys ++ prevRight ] ++ merged.animation)


filter : Item -> List Item -> ( List Item, List Item, List (KeyFrame Item) )
filter item list =
    case list of
        [] ->
            ( [], [], [ [ item ] ] )

        x :: xs ->
            let
                ( l, h, lowerHigherLog ) =
                    filter item xs
            in
            if x.value <= item.value then
                ( l ++ [ x ], h, List.map (\n -> n ++ [ x ]) lowerHigherLog ++ [ l ++ [ { x | color = "red" } ] ++ { item | color = "blue" } :: h ] )

            else
                ( l, h ++ [ x ], List.map (\n -> n ++ [ x ]) lowerHigherLog ++ [ l ++ { item | color = "blue" } :: h ++ [ { x | color = "red" } ] ] )


quickSort : List Item -> SortOutput
quickSort list =
    case list of
        [] ->
            SortOutput [] []

        x :: xs ->
            let
                ( lower, higher, lowerHigherLog ) =
                    filter x xs

                lowerSorted =
                    quickSort lower

                higherSorted =
                    quickSort higher

                frame =
                    lowerHigherLog
                        ++ List.map (\l -> l ++ [ x ] ++ higher) lowerSorted.animation
                        ++ List.map (\h -> lowerSorted.items ++ [ x ] ++ h) higherSorted.animation
                        ++ [ lowerSorted.items ++ [ x ] ++ higherSorted.items ]
            in
            SortOutput (lowerSorted.items ++ [ x ] ++ higherSorted.items) frame


bubbleSort : List Item -> SortOutput
bubbleSort list =
    bubbleSortHelper (List.length list) False [] [] list


bubbleSortHelper : Int -> Bool -> List (KeyFrame Item) -> List Item -> List Item -> SortOutput
bubbleSortHelper n swapped frames sorted list =
    if List.length sorted < n - 1 then
        case list of
            x :: y :: xs ->
                let
                    indicatedX =
                        { x | color = "red" }

                    indicatedY =
                        { y | color = "red" }
                in
                if x.value > y.value then
                    bubbleSortHelper n True (frames ++ [ sorted ++ [ indicatedY ] ++ (indicatedX :: xs) ]) (sorted ++ [ y ]) (x :: xs)

                else
                    bubbleSortHelper n swapped (frames ++ [ sorted ++ [ indicatedX ] ++ (indicatedY :: xs) ]) (sorted ++ [ x ]) (y :: xs)

            x :: xs ->
                let
                    indicatedX =
                        { x | color = "red" }
                in
                bubbleSortHelper n swapped (frames ++ [ sorted ++ [ indicatedX ] ++ xs ]) (sorted ++ [ x ]) xs

            [] ->
                if swapped then
                    bubbleSortHelper (n - 1) False frames [] sorted

                else
                    SortOutput sorted (frames ++ [ sorted ])

    else if swapped then
        bubbleSortHelper (n - 1) False frames [] (sorted ++ list)

    else
        SortOutput sorted (frames ++ [ sorted ++ list ])
