@echo off
cd Build
gfortran -c ..\DGA_Clustering.f95
gfortran -o DGA_Clustering.exe DGA_Clustering.o
del DGA_Clustering.o
cd ..
