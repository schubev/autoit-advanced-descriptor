type windowDescription =
  { title: string Js.Nullable.t
  ; className: string Js.Nullable.t
  ; regexpTitle: string Js.Nullable.t
  ; regexpClassName: string Js.Nullable.t
  ; last: bool Js.Nullable.t
  ; active: bool Js.Nullable.t
  ; x: int Js.Nullable.t
  ; y: int Js.Nullable.t
  ; w: int Js.Nullable.t
  ; h: int Js.Nullable.t
  ; instance: int Js.Nullable.t }
[@@bs.deriving abstract]

type windowDescriptor =
  | Title of string
  | ClassName of string
  | RegexpTitle of string
  | RegexpClassName of string
  | Last of bool
  | Active of bool
  | X of int
  | Y of int
  | W of int
  | H of int
  | Instance of int

let escaped s = s |. Js.String2.replaceByRe [%re "/;/g"] ";;"

let stringOfWindowDescriptor = function
  | Title title ->
      Some ("TITLE:" ^ escaped title)
  | ClassName className ->
      Some ("CLASS:" ^ escaped className)
  | RegexpTitle regexpTitle ->
      Some ("REGEXPTITLE:" ^ escaped regexpTitle)
  | RegexpClassName regexpClassName ->
      Some ("REGEXPCLASS:" ^ escaped regexpClassName)
  | Last last ->
      if last then Some "LAST" else None
  | Active active ->
      if active then Some "ACTIVE" else None
  | X x ->
      Some ("X:" ^ string_of_int x)
  | Y y ->
      Some ("Y:" ^ string_of_int y)
  | W w ->
      Some ("W:" ^ string_of_int w)
  | H h ->
      Some ("H:" ^ string_of_int h)
  | Instance instance ->
      Some ("INSTANCE:" ^ string_of_int instance)

let optionMap f = function Some x -> Some (f x) | None -> None

let filterSome xs =
  xs |. Js.Array2.filter Js.Option.isSome |. Js.Array2.map Js.Option.getExn

let splitDescription windowDescription =
  [| windowDescription |. titleGet |. Js.Nullable.toOption
     |> optionMap (fun title -> Title title)
   ; windowDescription |. classNameGet |. Js.Nullable.toOption
     |> optionMap (fun className -> ClassName className)
   ; windowDescription |. regexpTitleGet |. Js.Nullable.toOption
     |> optionMap (fun regexpTitle -> RegexpTitle regexpTitle)
   ; windowDescription |. regexpClassNameGet |. Js.Nullable.toOption
     |> optionMap (fun regexpClassName -> RegexpClassName regexpClassName)
   ; windowDescription |. lastGet |. Js.Nullable.toOption
     |> optionMap (fun last -> Last last)
   ; windowDescription |. activeGet |. Js.Nullable.toOption
     |> optionMap (fun active -> Active active)
   ; windowDescription |. xGet |. Js.Nullable.toOption
     |> optionMap (fun x -> X x)
   ; windowDescription |. yGet |. Js.Nullable.toOption
     |> optionMap (fun y -> Y y)
   ; windowDescription |. wGet |. Js.Nullable.toOption
     |> optionMap (fun w -> W w)
   ; windowDescription |. hGet |. Js.Nullable.toOption
     |> optionMap (fun h -> H h)
   ; windowDescription |. instanceGet |. Js.Nullable.toOption
     |> optionMap (fun instance -> Instance instance) |]
  |. filterSome

let descriptor windowDescription =
  let descriptors = splitDescription windowDescription in
  "["
  ^ ( descriptors
    |. Js.Array2.map stringOfWindowDescriptor
    |. filterSome |. Js.Array2.joinWith "; " )
  ^ "]"
