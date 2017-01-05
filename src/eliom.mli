(**
 * This module is provided as an example and should work immediately with
 * Ocsigen. It can be used as is in an actual website, but we expect website
 * administrators to be unsatisfied with exactly this module. Maybe the easiest
 * way to set up is to duplicate this module and adapt it to your needs.
 *)

open Eliom_content.Html5.D

val eliom_preset : ?colors:string list -> ?smileys_dir:string -> ?images_dir:string -> ?latex_dir:string -> begin

  val textarea : string -> Html5_types.flow5 elt
  (** [textarea id] creates a textareau with id [id], and provides buttons that
   * insert commands and environments easily. *)

  val preset_full : (Html5_types.flow5 elt) Preset.t

  (* The following presets are not meant to be used with parse in your
   * application but to be used by the commands and environments in
   * [preset_full]. *)

  val preset_phrasing : (Html5_types.phrasing elt) Preset.t
  val preset_coint : (Html5_types.no_interactive elt) Preset.t

end
