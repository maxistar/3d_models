/*
  1-key (piano-like hinge) + 2 MX switches on symmetry axis (X=0)
  Both switches trigger on DOWNSTROKE (key rotates about rear axis).

  Parts:
    key_hinged(): long key with hinge ears (M3 rod / screw axis)
    base_hinged(): base with hinge towers + 2 MX pockets centered (X=0), separated along Y

  Units: mm
*/

$fn = 64;

// ---------------- VIEW ----------------
show_key  = true;
show_base = true;
explode_z = 18; // separation for preview

// ---------------- KEY (hinged) ----------------
key_len = 160;      // longer, closer to piano feel
key_w   = 23.5;
key_t   = 6;

front_lip_h = 2.0;  // small front lip
front_lip_len = 2.5;

// Hinge axis position (distance from front edge)
hinge_y = 135;      // far from press point (piano-like)
hinge_axis_d = 3.0; // M3 rod/screw
hinge_clear = 0.25; // clearance in hinge hole
hinge_hole_d = hinge_axis_d + 2*hinge_clear;

// Hinge ears geometry on the key
ear_thick = 4.0;    // thickness along X
ear_len_y = 12.0;   // length along Y around hinge
ear_h = 10.0;       // height above key (ears stick upward)
ear_gap = 6.0;      // gap between ears (base tower sits between)
ear_outer_offset = 10.0; // half-distance of ears from center (X)

// Key underside "contact pads" that press switch stems (optional but helpful)
// You can also omit pads and let the flat key hit stems; pads help ensure contact point.
pad_size = 8.0;
padA_h = 2.2;       // pad height (downwards)
pad_delta = 0.9;    // B later => B pad shorter (downwards)
padB_h = padA_h - pad_delta;

// Switch Y positions (on symmetry axis X=0)
swA_y = 55;         // closer to front
swB_y = 73;         // further back (later in rotation if pads equal)
                     // NOTE: if you also use pad_delta, you get extra timing separation

// ---------------- BASE ----------------
base_margin = 10;
base_t = 8;

base_len = key_len + base_margin*2;
base_w = 60;        // enough for hinge towers + stability

// Hinge towers on base
tower_w = ear_gap;      // tower thickness along X (fits between ears)
tower_len_y = 14.0;     // tower depth along Y
tower_h = 22.0;         // tower height above base
tower_y = hinge_y + base_margin;  // base Y position for hinge (shifted by margin)

// MX pocket (simplified)
mx_body_w = 14.4;
mx_body_h = 14.4;
mx_pocket_depth = 5.2;

// Vertical placement of switches: pockets are cut into base top.
sw_pocket_z = base_t - mx_pocket_depth;

// Optional: travel stop (so key doesn't over-crush switches)
stops_enable = true;
stop_h = 2.0;
stop_w = 10.0;
stop_len = 6.0;
stop_y = swB_y + base_margin + 18; // behind switches

// ---------------- ASSEMBLY PREVIEW ----------------
if (show_base) base_hinged();
if (show_key)  translate([0, base_margin, base_t + explode_z]) key_hinged(); 
// ^ key is shifted in Y by base_margin so front aligns with base front margin

// ================= KEY =================
module key_hinged() {
  assert(padB_h > 0, "padB_h must be > 0. Reduce pad_delta or increase padA_h.");

  difference() {
    union() {
      // Main key slab
      translate([-key_w/2, 0, 0])
        cube([key_w, key_len, key_t], center=false);

      // Front lip
      translate([-key_w/2, 0, key_t])
        cube([key_w, front_lip_len, front_lip_h], center=false);

      // Hinge ears (two)
      for (sx = [-1, 1]) {
        translate([sx*ear_outer_offset - ear_thick/2, hinge_y - ear_len_y/2, key_t])
          cube([ear_thick, ear_len_y, ear_h], center=false);
      }

      // Optional underside pads centered on X=0 at swA_y and swB_y
      // Pads go DOWN (negative Z) to concentrate force on stems.
      // A pad taller, B pad shorter -> B triggers later in the same downstroke.
      translate([-pad_size/2, swA_y - pad_size/2, -padA_h])
        cube([pad_size, pad_size, padA_h], center=false);

      translate([-pad_size/2, swB_y - pad_size/2, -padB_h])
        cube([pad_size, pad_size, padB_h], center=false);
    }

    // Hinge holes through both ears (X direction)
    // We drill a cylinder across X through each ear volume.
    // Make a long cylinder and let it intersect both ears.
    translate([0, hinge_y, key_t + ear_h/2])
      rotate([0,90,0])
        cylinder(d=hinge_hole_d, h=2*ear_outer_offset + 2*ear_thick + 10, center=true);
  }
}

// ================= BASE =================
module base_hinged() {
  difference() {
    union() {
      // Base plate
      translate([-base_w/2, 0, 0])
        cube([base_w, base_len, base_t], center=false);

      // Hinge tower (between ears)
      translate([-tower_w/2, tower_y - tower_len_y/2, base_t])
        cube([tower_w, tower_len_y, tower_h], center=false);

      // Optional stops (key should hit stops instead of crushing stems too hard)
      if (stops_enable) {
        translate([-stop_w/2, stop_y, base_t])
          cube([stop_w, stop_len, stop_h], center=false);
      }
    }

    // Hinge axis hole through tower (X direction)
    translate([0, tower_y, base_t + tower_h/2])
      rotate([0,90,0])
        cylinder(d=hinge_hole_d, h=base_w + 20, center=true);

    // MX pockets centered on X=0 at swA_y and swB_y (shifted by base_margin)
    translate([-mx_body_w/2, (swA_y + base_margin) - mx_body_h/2, sw_pocket_z])
      cube([mx_body_w, mx_body_h, mx_pocket_depth + 0.3], center=false);

    translate([-mx_body_w/2, (swB_y + base_margin) - mx_body_h/2, sw_pocket_z])
      cube([mx_body_w, mx_body_h, mx_pocket_depth + 0.3], center=false);
  }

  // Visual markers (comment out if not needed)
  //switch_markers();
}

module switch_markers() {
  color([0.2,0.2,0.2,0.25])
  for (yy=[swA_y, swB_y]) {
    translate([0, yy + base_margin, base_t])
      cylinder(d=6, h=2);
  }
}
