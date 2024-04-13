[@@@ocaml.warning "-32-33"]

open Tsdl
open Tgl4

let ( >>= ) x f = match x with Ok v -> f v | Error _ as e -> e
let ( let* ) = Result.bind

module Palette = struct
  (* Colours Src: https://twitter.com/malenchi_alex/status/1778508064007831694/photo/1 *)
  let persimmon = "FF7433"
  let light_gray = "FCF5ED"
  let dove_gray = "D6CFC7"
  let jet_black = "191919"

  let hex_to_rgb hex =
    let int_of_hex h = int_of_string ("0x" ^ h) in
    let r = int_of_hex (String.sub hex 0 2) in
    let g = int_of_hex (String.sub hex 2 2) in
    let b = int_of_hex (String.sub hex 4 2) in
    (float_of_int r /. 255.0, float_of_int g /. 255.0, float_of_int b /. 255.0)

  (* Convert each color to RGB float triplet *)
  let persimmon_rgb = hex_to_rgb persimmon
  let light_gray_rgb = hex_to_rgb light_gray
  let dove_gray_rgb = hex_to_rgb dove_gray
  let jet_black_rgb = hex_to_rgb jet_black
end

let draw win =
  let open Palette in
  let r, g, b = dove_gray_rgb in
  Gl.clear_color r g b 1.;
  Gl.clear Gl.color_buffer_bit;
  (* Gl.use_program pid;
     Gl.bind_vertex_array gid;
     Gl.draw_elements Gl.triangles 3 Gl.unsigned_byte (`Offset 0);
     Gl.bind_vertex_array 0; *)
  Sdl.gl_swap_window win;
  ()

let create_window ~gl:(maj, min) =
  let w_atts = Sdl.Window.(opengl + resizable) in
  let w_title = Printf.sprintf "OpenGL %d.%d (core profile)" maj min in
  let set a v = Sdl.gl_set_attribute a v in
  set Sdl.Gl.context_profile_mask Sdl.Gl.context_profile_core >>= fun () ->
  set Sdl.Gl.context_major_version maj >>= fun () ->
  set Sdl.Gl.context_minor_version min >>= fun () ->
  set Sdl.Gl.doublebuffer 1 >>= fun () ->
  Sdl.create_window ~w:640 ~h:480 w_title w_atts >>= fun win ->
  Sdl.gl_create_context win >>= fun ctx ->
  Sdl.gl_make_current win ctx >>= fun () ->
  (* Sdl.log "%a" pp_opengl_info (); *)
  Ok (win, ctx)

let destroy_window win ctx =
  Sdl.gl_delete_context ctx;
  Sdl.destroy_window win;
  Ok ()

(* Event loop *)

let event_loop win draw =
  let e = Sdl.Event.create () in
  let key_scancode e = Sdl.Scancode.enum Sdl.Event.(get e keyboard_scancode) in
  let event e = Sdl.Event.(enum (get e typ)) in
  let window_event e = Sdl.Event.(window_event_enum (get e window_event_id)) in
  let rec loop () =
    Sdl.wait_event (Some e) >>= fun () ->
    match event e with
    | `Quit -> Ok ()
    | `Key_down when key_scancode e = `Escape -> Ok ()
    | `Window_event -> (
        match window_event e with
        | `Exposed | `Resized ->
            print_endline "Resized!!";
            let _w, _h = Sdl.get_window_size win in
            (* reshape win w h; *)
            draw win;
            loop ()
        | _ -> loop ())
    | _ -> loop ()
  in
  draw win;
  loop ()

let entry () =
  Sdl.init Sdl.Init.video >>= fun () ->
  create_window ~gl:(4, 1) >>= fun (win, ctx) ->
  (* create_geometry ()               >>= fun (gid, bids) -> *)
  (* create_program (glsl_version gl) >>= fun pid -> *)
  event_loop win draw >>= fun () ->
  (* delete_program pid               >>= fun () ->
     delete_geometry gid bids         >>= fun () -> *)
  destroy_window win ctx >>= fun () ->
  Sdl.quit ();
  Ok ()

let () =
  match entry () with
  | Ok _ -> print_endline "Progam exited successfully"
  | Error (`Msg s) -> print_endline ("Program exited with error " ^ s)
