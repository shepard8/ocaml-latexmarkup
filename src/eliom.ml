open Eliom_content.Html5.D

type text_format =
  | Bold | Italic | Underline | Strike
  | Link
  | Left | Right | Center
  | Secret

type color = string

module type CONFIG = sig
  val colors : color list
  val smileys_dir : string
  val images_dir : string
  val sizes : int list
  val headers : int -> bool
  val text_formats : text_format -> bool
  val math_inline : string -> Html5_types.flow5 elt
  val math_display : string -> Html5_types.flow5 elt
end

module DefaultConfig = struct
  let colors = []
  let smileys_dir = ""
  let images_dir = ""
  let sizes = []
  let headers _ = false
  let text_formats _ = false
  let math_inline s = pcdata ""
  let math_display s = pcdata ""
end

module Make (Config : CONFIG) = struct
  let preset = Preset.create (fun _ _ _ _ -> pcdata "") (fun _ _ _ -> pcdata "")
  let editor _ = pcdata ""
end

