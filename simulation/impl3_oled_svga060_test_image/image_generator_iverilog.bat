@echo off
if not exist out mkdir out
iverilog -o image_generator.o ..\..\impl3_oled_svga060_test_image\image_generator.v ..\..\impl3_oled_svga060_test_image\image_generator_tb.v ..\..\impl3_oled_svga060_test_image\test_screens_generator.v
vvp image_generator.o
del image_generator.o
move image_generator.vcd out
