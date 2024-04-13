(** Render module *)

[@@@ocaml.warning "-27-32-33-69"]

open Gg

type renderer = unit
(** Abstract renderer type *)

type perspective =
  | Orthographic of { width : int; height : int }
  | Perspective of { fov_radians : float }

(** Three vertices form a face *)
type face = v3 * v3 * v3


(** Calculates the normal vector for a face *)
let face_normal (_ : face) : v3 =
  failwith "TODO implement creating normal from face"


module Primitives = struct
  type cylinder = { radius : float; height : float }
  type cube = { extents: float }

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

type renderable = 
  Sprite
  | Mesh of face list

(** A scene is broadly all the things we want to draw per frame.
    
Some of the things you can do with a Scene are to sync it with the GPU,
and to ask the Renderer to draw it. *)
module Scene = struct
  type t = { entities : (string * renderable) list }

  let empty = { entities = [] }

  let add_primitive name (prim: Primitives.prim) (scene: t) : t =
    let mesh = Primitives.to_mesh prim in
    {  entities = (name, Mesh mesh) :: scene.entities}
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
        | Mesh faces -> 
          failwith "TODO draw faces")
      scene.entities
end
