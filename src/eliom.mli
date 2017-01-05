(**
 * This module is provided as an example and should work immediately with
 * Ocsigen. It can be used as is in an actual website, but we expect website
 * administrators to be unsatisfied with exactly this module. Maybe the easiest
 * way to set up is to duplicate this module and adapt it to your needs.
 *)

open Eliom_content.Html5.D

type text_format =
  | Bold | Italic | Underline | Strike
  | Link
  | Left | Right | Center
  | Secret

type color = string

module type CONFIG = sig
  val colors : color list
  (** An empty list deactivates the color functionality. *)

  val smileys_dir : string
  (** An empty string or a directory that does not exists  deactivates the
   * smiley functionality. *)

  val images_dir : string
  (** An empty string or a directory that does not exists deactivates the
   * images functionality. *)

  val sizes : int list
  (** An empty list deactivates the sizes functionality. Negative values are
   * wiped out before this check. *)

  val headers : int -> bool
  (** Specifies which headers (from 1 to 6) are available. If no one is
   * available, the headers bar will not be shown. *)

  val text_formats : text_format -> bool
  (** Specifies which text formats are available. If no one is available, the
   * text format bar will not be shown. *)

  val math_inline : string -> Html5_types.flow5 elt
  val math_display : string -> Html5_types.flow5 elt
end

module DefaultConfig : sig
  include CONFIG
end

module Make (Config : CONFIG) : sig

  val preset : (Html5_types.flow5 elt) Preset.t

  val editor : string -> Html5_types.flow5 elt

end
