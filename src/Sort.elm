module Sort exposing (..)


mergeSort : List comparable -> List comparable
mergeSort list =
    case list of
        [] ->
            []

        [ x ] ->
            [ x ]

        _ ->
            let
                ( left, right ) =
                    divideList list
            in
            merge (mergeSort left) (mergeSort right) []


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


merge : List comparable -> List comparable -> List comparable -> List comparable
merge left right sorted =
    case left of
        [] ->
            sorted ++ right

        x :: xs ->
            case right of
                [] ->
                    sorted ++ left

                y :: ys ->
                    if x <= y then
                        merge xs right (sorted ++ [ x ])

                    else
                        merge left ys (sorted ++ [ y ])


quickSort : List comparable -> ( List comparable, List (List comparable) )
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


bubbleSort : List comparable -> List (List comparable)
bubbleSort list =
    bubbleSortHelper (List.length list) False [] [] list


bubbleSortHelper : Int -> Bool -> List (List comparable) -> List comparable -> List comparable -> List (List comparable)
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
