
(* static const vec3 BACK_BOT_LEFT = (vec3){ 0, 0, 0 };
static const vec3 BACK_BOT_RIGHT = (vec3){ 1, 0, 0 };
static const vec3 BACK_TOP_LEFT = (vec3){ 0, 1, 0 };
static const vec3 BACK_TOP_RIGHT = (vec3){ 1, 1, 0 };
static const vec3 FRONT_BOT_LEFT = (vec3){ 0, 0, 1 };
static const vec3 FRONT_BOT_RIGHT = (vec3){ 1, 0, 1 };
static const vec3 FRONT_TOP_LEFT = (vec3){ 0, 1, 1 };
static const vec3 FRONT_TOP_RIGHT = (vec3){ 1, 1, 1 };

static mesh prim_cube_mesh_create() {
  mesh cube = { 0 };
  cube.vertices = vertex_darray_new(36);

  // back faces
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_BOT_LEFT, .normal = VEC3_NEG_Z, .uv = (vec2){ 0, 1 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_TOP_LEFT, .normal = VEC3_NEG_Z, .uv = (vec2){ 0, 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_TOP_RIGHT, .normal = VEC3_NEG_Z, .uv = (vec2){ 1, 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_TOP_RIGHT, .normal = VEC3_NEG_Z, .uv = (vec2){ 1, 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_BOT_RIGHT, .normal = VEC3_NEG_Z, .uv = (vec2){ 1, 1 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_BOT_LEFT, .normal = VEC3_NEG_Z, .uv = (vec2){ 0, 1 } });

  // front faces
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_BOT_LEFT, .normal = VEC3_Z, .uv = (vec2){ 0, 1 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_TOP_RIGHT, .normal = VEC3_Z, .uv = (vec2){ 1, 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_TOP_LEFT, .normal = VEC3_Z, .uv = (vec2){ 0, 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_BOT_LEFT, .normal = VEC3_Z, .uv = (vec2){ 0, 1 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_BOT_RIGHT, .normal = VEC3_Z, .uv = (vec2){ 1, 1 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_TOP_RIGHT, .normal = VEC3_Z, .uv = (vec2){ 1, 0 } });

  // top faces
  vertex_darray_push(cube.vertices,
                     (vertex){ .position = BACK_TOP_LEFT, .normal = VEC3_Y, .uv = (vec2){ 0, 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_TOP_LEFT, .normal = VEC3_Y, .uv = (vec2){ 0, 1 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_TOP_RIGHT, .normal = VEC3_Y, .uv = (vec2){ 1, 1 } });
  vertex_darray_push(cube.vertices,
                     (vertex){ .position = BACK_TOP_LEFT, .normal = VEC3_Y, .uv = (vec2){ 0, 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_TOP_RIGHT, .normal = VEC3_Y, .uv = (vec2){ 1, 1 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_TOP_RIGHT, .normal = VEC3_Y, .uv = (vec2){ 1, 0 } });

  // bottom faces
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_BOT_LEFT, .normal = VEC3_NEG_Y, .uv = (vec2){ 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_BOT_RIGHT, .normal = VEC3_NEG_Y, .uv = (vec2){ 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_BOT_LEFT, .normal = VEC3_NEG_Y, .uv = (vec2){ 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_BOT_LEFT, .normal = VEC3_NEG_Y, .uv = (vec2){ 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_BOT_RIGHT, .normal = VEC3_NEG_Y, .uv = (vec2){ 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_BOT_RIGHT, .normal = VEC3_NEG_Y, .uv = (vec2){ 0 } });

  // right faces
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_TOP_RIGHT, .normal = VEC3_X, .uv = (vec2){ 0, 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_BOT_RIGHT, .normal = VEC3_X, .uv = (vec2){ 1, 1 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_TOP_RIGHT, .normal = VEC3_X, .uv = (vec2){ 1, 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_BOT_RIGHT, .normal = VEC3_X, .uv = (vec2){ 1, 1 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_TOP_RIGHT, .normal = VEC3_X, .uv = (vec2){ 0, 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_BOT_RIGHT, .normal = VEC3_X, .uv = (vec2){ 0, 1 } });

  // left faces
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_TOP_LEFT, .normal = VEC3_NEG_X, .uv = (vec2){ 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_TOP_LEFT, .normal = VEC3_NEG_X, .uv = (vec2){ 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_BOT_LEFT, .normal = VEC3_NEG_X, .uv = (vec2){ 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = BACK_BOT_LEFT, .normal = VEC3_NEG_X, .uv = (vec2){ 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_BOT_LEFT, .normal = VEC3_NEG_X, .uv = (vec2){ 0 } });
  vertex_darray_push(
      cube.vertices,
      (vertex){ .position = FRONT_TOP_LEFT, .normal = VEC3_NEG_X, .uv = (vec2){ 0 } }); *)

open Gg
let back_bot_left = V3.v 0. 0. 0.
let back_bot_right = V3.v 1. 0. 0.
let back_top_left = V3.v 0. 1. 0.
let back_top_right = V3.v 1. 1. 0.

let make_plane () = 