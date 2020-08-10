module Sort exposing (animationFrames, bubbleSort, insertionSort, mergeSort, quickSort)

import Types exposing (AnimationFrame, Item, SortOutput)


animationFrames : SortOutput -> List AnimationFrame
animationFrames o =
    o.animation


insertionSort : List Item -> SortOutput
insertionSort list =
    insertionSortHelper list []


insertionSortHelper : List Item -> List Item -> SortOutput
insertionSortHelper list sorted =
    case list of
        [] ->
            SortOutput sorted [ AnimationFrame sorted 0 ]

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
                SortOutput (x :: y :: ys) [ AnimationFrame (rest ++ (indicatedX :: indicatedY :: ys)) 1 ]

            else
                let
                    inserted =
                        insert x ys (rest ++ [ y ])
                in
                SortOutput (y :: inserted.items) (AnimationFrame (rest ++ indicatedX :: indicatedY :: ys) 1 :: inserted.animation)

        [] ->
            SortOutput [ x ] [ AnimationFrame (rest ++ [ x ]) 0 ]


mergeSort : List Item -> SortOutput
mergeSort list =
    mergeSortHelper list [] []


mergeSortHelper : List Item -> List Item -> List Item -> SortOutput
mergeSortHelper list prevLeft prevRight =
    case list of
        [] ->
            SortOutput [] []

        [ x ] ->
            SortOutput list [ AnimationFrame (prevLeft ++ list ++ prevRight) 0 ]

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
            SortOutput (sorted ++ right) [ AnimationFrame (prevLeft ++ sorted ++ right ++ prevRight) 0 ]

        x :: xs ->
            case right of
                [] ->
                    SortOutput (sorted ++ left) [ AnimationFrame (prevLeft ++ sorted ++ left ++ prevRight) 0 ]

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
                        SortOutput merged.items (AnimationFrame (prevLeft ++ sorted ++ [ indicatedX ] ++ xs ++ indicatedY :: ys ++ prevRight) 1 :: merged.animation)

                    else
                        let
                            merged =
                                merge left ys (sorted ++ [ y ]) prevLeft prevRight
                        in
                        SortOutput merged.items (AnimationFrame (prevLeft ++ sorted ++ [ indicatedY ] ++ indicatedX :: xs ++ ys ++ prevRight) 1 :: merged.animation)


filter : Item -> List Item -> ( List Item, List Item, List AnimationFrame )
filter item list =
    case list of
        [] ->
            ( [], [], [ AnimationFrame [ item ] 0 ] )

        x :: xs ->
            let
                ( l, h, lowerHigherLog ) =
                    filter item xs
            in
            if x.value <= item.value then
                ( l ++ [ x ], h, List.map (\n -> { n | items = n.items ++ [ x ] }) lowerHigherLog ++ [ AnimationFrame (l ++ [ { x | color = "red" } ] ++ { item | color = "red" } :: h) 1 ] )

            else
                ( l, h ++ [ x ], List.map (\n -> { n | items = n.items ++ [ x ] }) lowerHigherLog ++ [ AnimationFrame (l ++ { item | color = "red" } :: h ++ [ { x | color = "red" } ]) 1 ] )


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
                        ++ List.map (\l -> { l | items = l.items ++ [ x ] ++ higher }) lowerSorted.animation
                        ++ List.map (\h -> { h | items = lowerSorted.items ++ [ x ] ++ h.items }) higherSorted.animation
                        ++ [ AnimationFrame (lowerSorted.items ++ [ x ] ++ higherSorted.items) 0 ]
            in
            SortOutput (lowerSorted.items ++ [ x ] ++ higherSorted.items) frame


bubbleSort : List Item -> SortOutput
bubbleSort list =
    bubbleSortHelper (List.length list) False [] [] list


bubbleSortHelper : Int -> Bool -> List AnimationFrame -> List Item -> List Item -> SortOutput
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
                    bubbleSortHelper n True (frames ++ [ AnimationFrame (sorted ++ [ indicatedY ] ++ (indicatedX :: xs)) 1 ]) (sorted ++ [ y ]) (x :: xs)

                else
                    bubbleSortHelper n swapped (frames ++ [ AnimationFrame (sorted ++ [ indicatedX ] ++ (indicatedY :: xs)) 1 ]) (sorted ++ [ x ]) (y :: xs)

            x :: xs ->
                let
                    indicatedX =
                        { x | color = "red" }

                    newFrames =
                        frames
                            ++ [ AnimationFrame (sorted ++ [ indicatedX ] ++ xs) 0 ]
                in
                bubbleSortHelper n swapped newFrames (sorted ++ [ x ]) xs

            [] ->
                if swapped then
                    bubbleSortHelper (n - 1) False frames [] sorted

                else
                    SortOutput sorted (frames ++ [ AnimationFrame sorted 0 ])

    else if swapped then
        bubbleSortHelper (n - 1) False frames [] (sorted ++ list)

    else
        SortOutput sorted (frames ++ [ AnimationFrame (sorted ++ list) 0 ])
