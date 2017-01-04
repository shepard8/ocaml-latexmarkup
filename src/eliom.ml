open Eliom_content.Html5.D

let eliom_preset ?colors ?smileys_dir ?images_dir ?latex_dir =
  let envfb c o a b = PCDATA c in
  let cmdfb c o a = PCDATA c in
  (module struct
    let textarea id = PCDATA "test"
    let preset = Preset.create envfb cmdfb
  end)
