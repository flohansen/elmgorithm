module Sort exposing (bubbleSort, keyFrames, mergeSort, quickSort)


type alias KeyFrame comparable =
    List comparable


keyFrames : ( List comparable, List (KeyFrame comparable) ) -> List (KeyFrame comparable)
keyFrames ( _, log ) =
    log


mergeSort : List comparable -> ( List comparable, List (KeyFrame comparable) )
mergeSort list =
    mergeSortHelper list [] []


mergeSortHelper : List comparable -> List comparable -> List comparable -> ( List comparable, List (KeyFrame comparable) )
mergeSortHelper list prevLeft prevRight =
    case list of
        [] ->
            ( [], [] )

        [ x ] ->
            ( list, [ prevLeft ++ list ++ prevRight ] )

        _ ->
            let
                ( left, right ) =
                    divideList list

                ( leftSorted, leftLog ) =
                    mergeSortHelper left prevLeft (right ++ prevRight)

                ( rightSorted, rightLog ) =
                    mergeSortHelper right (prevLeft ++ leftSorted) prevRight

                ( merged, mergedLog ) =
                    merge leftSorted rightSorted [] prevLeft prevRight

                log =
                    leftLog
                        ++ rightLog
                        ++ mergedLog
            in
            ( merged, log )


divideList : List comparable -> ( List comparable, List comparable )
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


merge : List comparable -> List comparable -> List comparable -> List comparable -> List comparable -> ( List comparable, List (KeyFrame comparable) )
merge left right sorted prevLeft prevRight =
    case left of
        [] ->
            ( sorted ++ right, [ prevLeft ++ sorted ++ right ++ prevRight ] )

        x :: xs ->
            case right of
                [] ->
                    ( sorted ++ left, [ prevLeft ++ sorted ++ left ++ prevRight ] )

                y :: ys ->
                    if x <= y then
                        let
                            ( merged, mergeLog ) =
                                merge xs right (sorted ++ [ x ]) prevLeft prevRight
                        in
                        ( merged, [ prevLeft ++ sorted ++ [ x ] ++ xs ++ right ++ prevRight ] ++ mergeLog )

                    else
                        let
                            ( merged, mergeLog ) =
                                merge left ys (sorted ++ [ y ]) prevLeft prevRight
                        in
                        ( merged, [ prevLeft ++ sorted ++ [ y ] ++ left ++ ys ++ prevRight ] ++ mergeLog )


quickSort : List comparable -> ( List comparable, List (KeyFrame comparable) )
quickSort list =
    case list of
        [] ->
            ( [], [] )

        pivot :: xs ->
            let
                lower =
                    List.filter (\n -> n <= pivot) xs

                higher =
                    List.filter (\n -> n > pivot) xs

                ( lowerSorted, lowerFrame ) =
                    quickSort lower

                ( higherSorted, higherFrame ) =
                    quickSort higher

                frame =
                    List.map (\l -> l ++ [ pivot ] ++ higher) lowerFrame
                        ++ List.map (\h -> lowerSorted ++ [ pivot ] ++ h) higherFrame
                        ++ [ lowerSorted ++ [ pivot ] ++ higherSorted ]
            in
            ( lowerSorted ++ [ pivot ] ++ higherSorted, frame )


bubbleSort : List comparable -> List (KeyFrame comparable)
bubbleSort list =
    bubbleSortHelper (List.length list) False [] [] list


bubbleSortHelper : Int -> Bool -> List (KeyFrame comparable) -> List comparable -> List comparable -> List (KeyFrame comparable)
bubbleSortHelper n swapped frames sorted list =
    if List.length sorted < n - 1 then
        case list of
            x :: y :: xs ->
                if x > y then
                    bubbleSortHelper n True (frames ++ [ sorted ++ [ y ] ++ (x :: xs) ]) (sorted ++ [ y ]) (x :: xs)

                else
                    bubbleSortHelper n swapped (frames ++ [ sorted ++ [ x ] ++ (y :: xs) ]) (sorted ++ [ x ]) (y :: xs)

            x :: xs ->
                bubbleSortHelper n swapped (frames ++ [ sorted ++ [ x ] ++ xs ]) (sorted ++ [ x ]) xs

            [] ->
                if swapped then
                    bubbleSortHelper (n - 1) False frames [] sorted

                else
                    frames ++ [ sorted ]

    else if swapped then
        bubbleSortHelper (n - 1) False frames [] (sorted ++ list)

    else
        frames ++ [ sorted ++ list ]
