type windowDescription =
  { title: string Js.Nullable.t
  ; className: string Js.Nullable.t
  ; regexpTitle: string Js.Nullable.t
  ; regexpClassName: string Js.Nullable.t
  ; text: string Js.Nullable.t
  ; last: bool Js.Nullable.t
  ; active: bool Js.Nullable.t
  ; x: int Js.Nullable.t
  ; y: int Js.Nullable.t
  ; w: int Js.Nullable.t
  ; h: int Js.Nullable.t
  ; instance: int Js.Nullable.t }
[@@bs.deriving abstract]

let escaped s = s |. Js.String2.replaceByRe [%re "/;/g"] ";;"

let addStringDescriptor acc key value =
  let value = Js.Nullable.toOption value in
  match value with
  | Some value ->
      ignore @@ Js.Array2.push acc (key ^ ":" ^ escaped value)
  | None ->
      ()

let addIntegerDescriptor acc key value =
  let value = Js.Nullable.toOption value in
  match value with
  | Some value ->
      ignore @@ Js.Array2.push acc (key ^ ":" ^ string_of_int @@ value)
  | None ->
      ()

let addBooleanDescriptor acc key value =
  let value = Js.Nullable.toOption value in
  match value with
  | Some true ->
      ignore @@ Js.Array2.push acc key
  | Some false | None ->
      ()

let descriptorTagged ~title ~className ~regexpTitle ~regexpClassName ~text
    ~last ~active ~x ~y ~w ~h ~instance =
  let descriptors = [||] in
  addStringDescriptor descriptors "TITLE" title ;
  addStringDescriptor descriptors "CLASS" className ;
  addStringDescriptor descriptors "REGEXPTITLE" regexpTitle ;
  addStringDescriptor descriptors "REGEXPCLASS" regexpClassName ;
  addStringDescriptor descriptors "TEXT" text ;
  addIntegerDescriptor descriptors "INSTANCE" instance ;
  addBooleanDescriptor descriptors "ACTIVE" active ;
  addBooleanDescriptor descriptors "LAST" last ;
  addIntegerDescriptor descriptors "X" x ;
  addIntegerDescriptor descriptors "Y" y ;
  addIntegerDescriptor descriptors "W" w ;
  addIntegerDescriptor descriptors "H" h ;
  let body = descriptors |. Js.Array2.joinWith "; " in
  "[" |. Js.String2.concatMany [|body; "]"|]

let descriptor windowDescription =
  let title = windowDescription |. titleGet in
  let className = windowDescription |. classNameGet in
  let regexpTitle = windowDescription |. regexpTitleGet in
  let regexpClassName = windowDescription |. regexpClassNameGet in
  let text = windowDescription |. textGet in
  let instance = windowDescription |. instanceGet in
  let active = windowDescription |. activeGet in
  let last = windowDescription |. lastGet in
  let x = windowDescription |. xGet in
  let y = windowDescription |. yGet in
  let w = windowDescription |. wGet in
  let h = windowDescription |. hGet in
  descriptorTagged ~title ~className ~regexpTitle ~regexpClassName ~text
    ~instance ~active ~last ~x ~y ~w ~h
