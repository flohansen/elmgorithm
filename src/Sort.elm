module Sort exposing (bubbleSort, insertionSort, keyFrames, mergeSort, quickSort)

import Types exposing (Item)


type alias KeyFrame comparable =
    List comparable


type alias SortOutput =
    ( List Item, List (KeyFrame Item) )


keyFrames : SortOutput -> List (KeyFrame Item)
keyFrames ( _, log ) =
    log


insertionSort : List Item -> SortOutput
insertionSort list =
    insertionSortHelper list []


insertionSortHelper : List Item -> List Item -> SortOutput
insertionSortHelper list sorted =
    case list of
        [] ->
            ( sorted, [ sorted ] )

        x :: xs ->
            let
                ( inserted, insertedLog ) =
                    insert x sorted xs

                ( insertedSorted, insertedSortedLog ) =
                    insertionSortHelper xs inserted

                log =
                    insertedLog
                        ++ insertedSortedLog
            in
            ( insertedSorted, log )


insert : Item -> List Item -> List Item -> SortOutput
insert x list rest =
    case list of
        y :: ys ->
            if x.value <= y.value then
                ( x :: y :: ys, [ rest ++ (x :: y :: ys) ] )

            else
                let
                    ( inserted, insertedLog ) =
                        insert x ys (rest ++ [ y ])
                in
                ( y :: inserted, (rest ++ x :: list) :: insertedLog )

        [] ->
            ( [ x ], [ rest ++ [ x ] ] )


mergeSort : List Item -> SortOutput
mergeSort list =
    mergeSortHelper list [] []


mergeSortHelper : List Item -> List Item -> List Item -> SortOutput
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
            ( sorted ++ right, [ prevLeft ++ sorted ++ right ++ prevRight ] )

        x :: xs ->
            case right of
                [] ->
                    ( sorted ++ left, [ prevLeft ++ sorted ++ left ++ prevRight ] )

                y :: ys ->
                    if x.value <= y.value then
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


quickSort : List Item -> SortOutput
quickSort list =
    case list of
        [] ->
            ( [], [] )

        pivot :: xs ->
            let
                lower =
                    List.filter (\n -> n.value <= pivot.value) xs

                higher =
                    List.filter (\n -> n.value > pivot.value) xs

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


bubbleSort : List Item -> SortOutput
bubbleSort list =
    bubbleSortHelper (List.length list) False [] [] list


bubbleSortHelper : Int -> Bool -> List (KeyFrame Item) -> List Item -> List Item -> SortOutput
bubbleSortHelper n swapped frames sorted list =
    if List.length sorted < n - 1 then
        case list of
            x :: y :: xs ->
                if x.value > y.value then
                    bubbleSortHelper n True (frames ++ [ sorted ++ [ y ] ++ (x :: xs) ]) (sorted ++ [ y ]) (x :: xs)

                else
                    bubbleSortHelper n swapped (frames ++ [ sorted ++ [ x ] ++ (y :: xs) ]) (sorted ++ [ x ]) (y :: xs)

            x :: xs ->
                bubbleSortHelper n swapped (frames ++ [ sorted ++ [ x ] ++ xs ]) (sorted ++ [ x ]) xs

            [] ->
                if swapped then
                    bubbleSortHelper (n - 1) False frames [] sorted

                else
                    ( sorted, frames ++ [ sorted ] )

    else if swapped then
        bubbleSortHelper (n - 1) False frames [] (sorted ++ list)

    else
        ( sorted, frames ++ [ sorted ++ list ] )
