/*
  1-key MVP (downstroke velocity):
  - 2 MX switches under key
  - Key moves down
  - A pad hits first, B pad hits later (by height difference pad_delta)
  - Measure Δt between A and B switch press events

  Parts:
    key()  : keycap/lever plate with guide holes + two pads (A higher, B lower)
    base() : base plate with M3 guide posts + MX pockets + optional hotswap pockets

  Units: mm
*/

$fn = 64;

// ---------- VIEW ----------
show_key  = true;
show_base = true;
explode_z = 14;   // visual separation between parts

// ---------- KEY PARAMETERS ----------
key_len = 90;
key_w   = 23.5;
key_t   = 5;

travel = 4.2;          // intended down travel (controlled by stops)
pad_size = 7.0;        // pad footprint (square)
padA_h  = 2.0;         // pad height for A (hits earlier)
pad_delta = 0.8;       // B hits later => B pad is LOWER (smaller height)
padB_h  = padA_h - pad_delta;  // must stay > 0

// Guides (M3 screws used as posts)
guide_spacing = 15.0;     // distance between two guides (X axis)
guide_from_front = 18.0;  // guide holes Y position measured from key front
guide_d_nom = 3.0;
guide_hole_clear = 0.35;  // increase if binding
guide_hole_d = guide_d_nom + 2*guide_hole_clear;

// ---------- BASE PARAMETERS ----------
base_margin = 7;
base_t = 6;

// Guide posts (printed pillars with optional through-hole for M3)
post_d = 5.2;
post_h = key_t + travel + 5;
post_hole = true;
post_hole_d = 3.2;

// Switch geometry (MX body pocket - simplified)
mx_body_w = 14.3;     // add clearance
mx_body_h = 14.3;
mx_pocket_depth = 5.2;

// Distance between switch centers (X axis)
// 19 mm is a practical starting point; adjust to fit your housing.
mx_center_spacing = 19.0;

// Where switches sit along Y (from base front). Adjust to place pads under key.
mx_y = base_margin + 48;  // shift back/forward as you like

// Optional hotswap socket pocket (Kailh MX style) - very simplified
hotswap_enable = true;
hotswap_w = 17.0;     // overall pocket width (X)
hotswap_h = 16.0;     // overall pocket height (Y)
hotswap_depth = 2.4;  // how deep pocket under switch area
hotswap_y_offset = 0; // fine shift if needed

// Stops (limit travel so you don't crush switches)
stops_enable = true;
stop_w = 4.5;
stop_l = 6.0;
stop_h = 1.8;
stop_y = mx_y + 10;   // behind switches
stop_x_inset = 2.0;   // how close to key edges

// ---------- ASSEMBLY PREVIEW ----------
if (show_base) base();
if (show_key)  translate([0,0, base_t + explode_z]) key();

// =================== KEY ===================
module key() {
  assert(padB_h > 0, "padB_h must be > 0. Reduce pad_delta or increase padA_h.");

  difference() {
    union() {
      // main plate
      translate([-key_w/2, 0, 0])
        cube([key_w, key_len, key_t], center=false);

      // optional small front lip
      translate([-key_w/2, 0, key_t])
        cube([key_w, 2.0, 2.0], center=false);

      // pads on underside, aligned to switch centers
      // Left = A (earlier), Right = B (later)
      // IMPORTANT: because pads extrude downward (negative Z),
      // a TALLER pad touches the switch sooner during downstroke.
      // => A pad is taller than B pad.
      // A pad
      translate([-mx_center_spacing/2 - pad_size/2, mx_y - pad_size/2, -padA_h])
        cube([pad_size, pad_size, padA_h], center=false);

      // B pad
      translate([ mx_center_spacing/2 - pad_size/2, mx_y - pad_size/2, -padB_h])
        cube([pad_size, pad_size, padB_h], center=false);
    }

    // guide holes (through key)
    for (sx=[-0.5, 0.5]) {
      translate([sx*guide_spacing, guide_from_front, -1])
        cylinder(d=guide_hole_d, h=key_t+2);
    }
  }
}

// =================== BASE ===================
module base() {
  base_len = key_len + base_margin*2;
  base_w   = max(key_w + base_margin*2, mx_center_spacing + base_margin*2 + 14);

  difference() {
    union() {
      // base plate
      translate([-base_w/2, 0, 0])
        cube([base_w, base_len, base_t], center=false);

      // guide posts
      for (sx=[-0.5, 0.5]) {
        translate([sx*guide_spacing, base_margin + guide_from_front, base_t])
          cylinder(d=post_d, h=post_h);
      }

      // travel stops (key should hit these, not over-crush switches)
      if (stops_enable) {
        // Two stops near left/right edges
        translate([-key_w/2 + stop_x_inset, stop_y, base_t])
          cube([stop_w, stop_l, stop_h], center=false);

        translate([ key_w/2 - stop_x_inset - stop_w, stop_y, base_t])
          cube([stop_w, stop_l, stop_h], center=false);
      }
    }

    // MX switch body pockets (simplified square cavities)
    for (sx=[-0.5, 0.5]) {
      translate([sx*mx_center_spacing - mx_body_w/2, mx_y - mx_body_h/2, base_t - mx_pocket_depth])
        cube([mx_body_w, mx_body_h, mx_pocket_depth + 0.3], center=false);
    }

    // Optional hotswap pocket under each switch area (very simplified)
    // This is NOT a perfect datasheet model; it's a practical clearance pocket.
    if (hotswap_enable) {
      for (sx=[-0.5, 0.5]) {
        translate([sx*mx_center_spacing - hotswap_w/2, (mx_y - hotswap_h/2) + hotswap_y_offset, base_t - mx_pocket_depth - hotswap_depth])
          cube([hotswap_w, hotswap_h, hotswap_depth + 0.3], center=false);
      }
    }

    // Guide post through-holes (if using M3 screws)
    if (post_hole) {
      for (sx=[-0.5, 0.5]) {
        translate([sx*guide_spacing, base_margin + guide_from_front, -1])
          cylinder(d=post_hole_d, h=base_t + post_h + 3);
      }
    }
  }

  // (Optional) visualize switch center markers
  // switch_markers();
}

module switch_markers() {
  // purely visual helpers, no cutting
  color([0.2,0.2,0.2,0.25])
  for (sx=[-0.5, 0.5]) {
    translate([sx*mx_center_spacing, mx_y, base_t])
      cylinder(d=6, h=2);
  }
}
