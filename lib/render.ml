(** Render module *)

[@@@ocaml.warning "-26-27-32-33-69"]

open Gg
open Tgl4

let bigarray_create k len = Bigarray.(Array1.create k c_layout len)
let get_int =
  let a = bigarray_create Bigarray.int32 1 in
  fun f -> f a; Int32.to_int a.{0}

(* let set_int =
  let a = bigarray_create Bigarray.int32 1 in
  fun f i -> a.{0} <- Int32.of_int i; f a *)

type renderer = unit
(** Abstract renderer type *)

type perspective =
  | Orthographic of { width : int; height : int }
  | Perspective of { fov_radians : float }

type face = v3 * v3 * v3
(** Three vertices form a face *)

(** Calculates the normal vector for a face *)
let face_normal (_ : face) : v3 =
  failwith "TODO implement creating normal from face"

module Primitives = struct
  type cylinder = { radius : float; height : float }
  type cube = { extents : float }

  module Cylinder = struct
    let mesh cyl = failwith "todo meshing"
  end

  module Cube = struct
    let mesh cube = []
  end

  type prim = CylPrim of cylinder | CubePrim of cube

  let to_mesh = function
    | CylPrim c -> Cylinder.mesh c
    | CubePrim c -> Cube.mesh c
end

module Resource = struct
  type buffer
  type texture
end

module Geometry = struct
  type vertex = {
    pos: v3;
    color: v3
  }
  type packet = {
    vertices: vertex list;
    indices: int list
  }

  let make () =
    let vao = get_int (Gl.gen_vertex_arrays 1) in
    let vbo = get_int (Gl.gen_buffers 1) in
    let ibo = get_int (Gl.gen_buffers 1) in
    ()


end

type renderable = Sprite | Mesh of Geometry.packet

(** A scene is broadly all the things we want to draw per frame.
    
Some of the things you can do with a Scene are to sync it with the GPU,
and to ask the Renderer to draw it. *)
module Scene = struct
  type t = { entities : (string * renderable) list }

  let empty = { entities = [] }

  let add_primitive name (prim : Primitives.prim) (scene : t) : t =
    scene
    (* let mesh = Primitives.to_mesh prim in
    { entities = (name, Mesh mesh) :: scene.entities } *)
end

module Renderer = struct
  let render_scene (ren : renderer) (scene : Scene.t) =
    List.iter
      (fun entity ->
        let name, render_ent = entity in
        Printf.printf "Rendering %s\n" name;
        let _model_tf = M4.id in
        match render_ent with
        | Sprite -> ()
        | Mesh faces -> failwith "TODO draw faces")
      scene.entities
end
