module Sort exposing (..)


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
