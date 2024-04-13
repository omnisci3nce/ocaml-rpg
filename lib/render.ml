(** Render module *)

open Gg

(** Abstract renderer type *)
type renderer

type perspective =
  | Orthographic of { width : int; height : int }
  | Perspective of { fov_radians : float }

type face = (v3 * v3 * v3) (** Three vertices form a face *)

(** Calculates the normal vector for a face *)
let face_normal (_: face) : v3 = failwith "TODO implement creating normal from face"

module type MeshPrimitive = sig
  type t
  val make : t -> face list
end

type renderable = {
    draw : renderer -> m4 -> unit;
        (** Take an affine transform and draw the thing to the screen*)
  }

module type Renderable = sig
  type t
  val to_renderable : t -> renderable
end

module Primitives = struct
  module Cylinder = struct
    type t = { radius: float; height: float }
  end
  module Cone = struct
    type t = { radius: float; height: float }
  end
  module Cuboid = struct
    type t
  end

  type prim =
    CylPrim of Cylinder.t
    | CuboidPrim of Cuboid.t
    | ConePrim of Cone.t
end

module Resource = struct
  type buffer
  type texture
end

(** A scene is broadly all the things we want to draw per frame.
    
Some of the things you can do with a Scene are to sync it with the GPU,
and to ask the Renderer to draw it. *)
module Scene = struct

  type render_entity = [
    `Prim of Primitives.prim
  ]

  type t = { entities : render_entity list }
end

module Renderer = struct
  type t

  let render_scene ren scene = failwith "TODO implement Renderer"
end
