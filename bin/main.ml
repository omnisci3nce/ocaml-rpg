[@@@ocaml.warning "-32-33"]

open Tsdl
open Tgl4

let ( >>= ) x f = match x with Ok v -> f v | Error _ as e -> e
let ( let* ) = Result.bind
let draw _win = ()

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
