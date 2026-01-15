/*
  1-key MVP: короткая “синт-клавиша” + 2 MX-свитча под ней + ступенька (A раньше, B позже)
  OpenSCAD: две детали
    - key()  : сама клавиша с направляющими отверстиями и двумя pads разной высоты
    - base() : основание с двумя стойками-направляющими (на M3) и карманами под MX

  Единицы: мм
  Советы:
   - Для прототипа печатай KEY и BASE отдельно.
   - KEY лучше печатать “верхом вверх” (плоской стороной на стол).
   - В BASE стойки лучше печатать вместе с основанием (или как отдельные детали).
   source: https://chatgpt.com/c/696551ba-1840-8330-857e-2754e7f56b41
*/

$fn = 64;

// -------------------- Параметры --------------------
show_key  = true;
show_base = true;
explode   = 12;  // разнос деталей для просмотра

// KEY (клавиша)
key_len = 90;
key_w   = 23.5;
key_t   = 5;

travel = 4.2;              // общий ход клавиши вниз (задаётся механикой упора)
pad_size = 7.0;            // квадратный "пятачок" под нажим на шток свитча
padA_h  = 2.0;             // высота A-pad
pad_delta = 0.8;           // B позже => B-pad ниже на pad_delta
padB_h  = padA_h - pad_delta;

// Направляющие (винты M3 как стойки)
guide_d_nom = 3.0;         // номинал M3
guide_hole_clear = 0.35;   // зазор под скольжение (увеличь до 0.45 если клинит)
guide_hole_d = guide_d_nom + 2*guide_hole_clear;

guide_spacing = 15.0;      // расстояние между направляющими по ширине
guide_from_front = 18.0;   // отступ оси направляющих от переднего края клавиши

// BASE (основание)
base_margin = 6;           // поля вокруг геометрии
base_t = 6;

// Стойки-направляющие (под винты M3)
post_d = 5.2;              // диаметр стойки (достаточно толстая для жёсткости)
post_h = key_t + travel + 4;   // высота стойки
post_hole_d = 3.2;         // отверстие под винт M3 (если хочешь винт насквозь)
post_hole = true;          // делать отверстие под винт в стойках?

// MX карманы (упрощённо, без "plate cutout" под защёлки)
mx_body_w = 14.2;          // квадрат под корпус MX (чуть с зазором)
mx_body_h = 14.2;
mx_pocket_depth = 5.0;     // глубина кармана
mx_center_spacing = 19.0;  // расстояние между центрами двух свитчей (подгони под свой корпус)

// Позиции свитчей относительно BASE (центр)
mx_y = base_margin + guide_from_front + 32;  // смещение назад: чтобы pads были ближе к центру клавиши
// ^ Можно подгонять: чем дальше назад, тем меньше "перекос" при нажатии пальцем спереди.

// -------------------- Сборка для превью --------------------
if (show_base) base();

if (show_key) translate([0,0, base_t + explode]) key();

// -------------------- Деталь: KEY --------------------
module key(){
  difference(){
    union(){
      // Основная пластина
      translate([-key_w/2, 0, 0])
        cube([key_w, key_len, key_t], center=false);

      // A-pad и B-pad снизу (разной высоты)
      // Размещаем pads над центрами MX-свитчей.
      // Их Y-координаты должны совпасть с mx_y в base().
      for (i=[-0.5, 0.5]){
        // A-pad слева (i=-0.5), B-pad справа (i=0.5)
        pad_h = (i < 0) ? padA_h : padB_h;

        translate([i*mx_center_spacing - pad_size/2, mx_y - pad_size/2, -pad_h])
          cube([pad_size, pad_size, pad_h], center=false);
      }

      // Небольшой "бортик" спереди (опционально, чтобы палец не соскальзывал)
      translate([-key_w/2, 0, key_t])
        cube([key_w, 2.0, 2.0], center=false);
    }

    // Отверстия под направляющие (сквозь клавишу)
    for (i=[-0.5, 0.5]){
      translate([i*guide_spacing, guide_from_front, -1])
        cylinder(d=guide_hole_d, h=key_t+2);
    }
  }
}

// -------------------- Деталь: BASE --------------------
module base(){
  // Размер основания по длине под KEY и механику
  base_len = key_len + base_margin*2;
  base_w   = max(key_w + base_margin*2, mx_center_spacing + base_margin*2 + 10);

  difference(){
    union(){
      // Плита основания
      translate([-base_w/2, 0, 0])
        cube([base_w, base_len, base_t], center=false);

      // Стойки-направляющие
      for (i=[-0.5, 0.5]){
        translate([i*guide_spacing, base_margin + guide_from_front, base_t])
          cylinder(d=post_d, h=post_h);
      }

      // Простые "стопы" (упоры) сверху основания, чтобы ограничить ход клавиши (опционально)
      // Идея: клавиша упирается не в свитчи, а в эти стопы/демпфер.
      // На прототипе можно просто наклеить TPU/силикон на эти зоны.
      stop_w = 4;
      stop_h = 2;
      stop_y = mx_y + 8; // чуть позади свитчей
      for (i=[-0.5, 0.5]){
        translate([i*(key_w/2 - stop_w/2), stop_y, base_t])
          cube([stop_w, 6, stop_h], center=false);
      }
    }

    // Карманы под два MX-свитча (упрощённые)
    for (i=[-0.5, 0.5]){
      translate([i*mx_center_spacing - mx_body_w/2, mx_y - mx_body_h/2, base_t - mx_pocket_depth])
        cube([mx_body_w, mx_body_h, mx_pocket_depth+0.2], center=false);
    }

    // Отверстия под стойки (если хочешь винт M3)
    if (post_hole){
      for (i=[-0.5, 0.5]){
        translate([i*guide_spacing, base_margin + guide_from_front, base_t - 1])
          cylinder(d=post_hole_d, h=post_h + base_t + 2);
      }
    }
  }

  // Визуализация мест свитчей (не вырез, просто подсказка)
  //comment_switches();
}

// Подсказка (не используется): отрисовать "макеты" свитчей
module comment_switches(){
  color("gray", 0.3)
  for (i=[-0.5, 0.5]){
    translate([i*mx_center_spacing, mx_y, base_t])
      cube([14,14,10], center=true);
  }
}
