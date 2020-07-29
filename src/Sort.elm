module Sort exposing (..)


quickSort : List comparable -> List comparable
quickSort list =
    case list of
        [] ->
            []

        pivot :: xs ->
            let
                min =
                    List.filter (\n -> n <= pivot) xs

                max =
                    List.filter (\n -> n > pivot) xs
            in
            quickSort min ++ [ pivot ] ++ quickSort max
