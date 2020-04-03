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

val descriptorTagged :
     title:string Js.Nullable.t
  -> className:string Js.Nullable.t
  -> regexpTitle:string Js.Nullable.t
  -> regexpClassName:string Js.Nullable.t
  -> text:string Js.Nullable.t
  -> last:bool Js.Nullable.t
  -> active:bool Js.Nullable.t
  -> x:int Js.Nullable.t
  -> y:int Js.Nullable.t
  -> w:int Js.Nullable.t
  -> h:int Js.Nullable.t
  -> instance:int Js.Nullable.t
  -> string

val descriptor : windowDescription -> string
