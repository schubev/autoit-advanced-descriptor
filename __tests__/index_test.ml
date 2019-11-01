open Jest
open Expect
open Index

let d ?title ?className ?regexpTitle ?regexpClassName ?last ?active ?x ?y ?w ?h
    ?instance () =
  let title = title |. Js.Nullable.fromOption in
  let className = className |. Js.Nullable.fromOption in
  let regexpTitle = regexpTitle |. Js.Nullable.fromOption in
  let regexpClassName = regexpClassName |. Js.Nullable.fromOption in
  let last = last |. Js.Nullable.fromOption in
  let active = active |. Js.Nullable.fromOption in
  let x = x |. Js.Nullable.fromOption in
  let y = y |. Js.Nullable.fromOption in
  let w = w |. Js.Nullable.fromOption in
  let h = h |. Js.Nullable.fromOption in
  let instance = instance |. Js.Nullable.fromOption in
  descriptorTagged ~title ~className ~regexpTitle ~regexpClassName ~last
    ~active ~x ~y ~w ~h ~instance

let cases =
  [ ("[]", fun () -> d ())
  ; ("[TITLE:toto]", fun () -> d ~title:"toto" ())
  ; ("[INSTANCE:42]", fun () -> d ~instance:42 ())
  ; ("[X:42; Y:84; W:10; H:20]", fun () -> d ~x:42 ~y:84 ~w:10 ~h:20 ())
  ; ("[ACTIVE]", fun () -> d ~active:true ())
  ; ("[]", fun () -> d ~active:false ())
  ; ("[LAST]", fun () -> d ~last:true ())
  ; ("[]", fun () -> d ~last:false ())
  ; ("[TITLE:ta;;ta]", fun () -> d ~title:"ta;ta" ())
  ; ("[TITLE:toto; ACTIVE]", fun () -> d ~title:"toto" ~active:true ())
  ; ("[TITLE:toto; CLASS:tata]", fun () -> d ~title:"toto" ~className:"tata" ())
  ; ( "[TITLE:to;;to; CLASS:tata]"
    , fun () -> d ~title:"to;to" ~className:"tata" () )
  ; ( "[TITLE:toto; CLASS:ta;;ta]"
    , fun () -> d ~title:"toto" ~className:"ta;ta" () )
  ; ( "[TITLE:to;;to; CLASS:ta;;ta]"
    , fun () -> d ~title:"to;to" ~className:"ta;ta" () ) ]

let makeTest (expected, case) =
  test expected (fun () -> expect (case ()) |> toEqual expected)

let () = describe "descriptor" (fun () -> cases |> List.iter makeTest)
