import("stdfaust.lib");

freq = hslider("Frequency", 262, 100, 1000, 0.1);
gain = hslider("Volume", 0.1, 0, 1, 0.01);
saw = os.lf_saw(freq);
square = os.lf_squarewave(freq);
saw_square = nentry("saw/square", 0, 0, 1, 1), saw, square : select2;
process = saw_square : _,gain : * <: _,_;
