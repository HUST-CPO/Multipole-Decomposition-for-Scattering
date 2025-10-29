# MDS: Multipole Decomposition for Scattering
![multipole_schematic](/assets/img/fig_schematic.png)

## Overview
The open-source MATLAB package MDS is a numerical projection program for multipole decomposition. Lebedev and Gaussian quadrature method are introduced to calculate the surface and volume integrals in the numerical projection procedure, respectively. The program can compute high-order electromagnetic multipoles up to 8th order. 

Two approaches for numerical projection are included, each suitable for different situations. The first type is surface integration based on the scattered field outside the scatterer, which is used for the multipole analysis of single scatterer. The second type is volume integration based on the induced current density inside the scatterer, which is applicable to the building blocks in periodic structures such as metasurfaces and photonic crystals. 

## Citation
If you find MDS useful for your research, please consider citing the following paper:

[Wenfei Guo, Zizhe Cai, Zhongfei Xiong, Weijin Chen, and Yuntian Chen, ``Efficient and accurate numerical-projection of electromagnetic multipoles for scattering objects,'' Front. Optoelectron. 16, 48 (2023).](https://doi.org/10.1007/s12200-023-00102-2)

## Usage
The functions for surface/volume integration method are provided in `./MDS`. Codes for Mie theory calculation are also included for reference. 
### Functions for surface integration method
`generate_sphere_pt.m`: Generate Lebedev quadrature weights and points that are given in both Cartesian and spherical coordinates.

### Functions for volume integration method
`quad_point52tetra.m`: Get the Gaussian quadrature points and corresponding weights inside the scatterer. 

### Common functions for both two methods
1. `field_build.m`: Read the scattered field/induced current density at each quadrature point computed by COMSOL.
2. `field_from_cart2sph.m`: Convert the field data in the Cartesian coordinate to spherical coordinate.
3. `pm6_NeMo.m`: Calculate electric and magnetic multipole coefficients `aml` and `bml`. The expressions of vector spherical harmonics up to 8th order are included in this function. 
4. `coff.m`: Summation for quadrature. 

### Functions for Mie theory
1. `mie_scatter.m`: Compute the multipole coefficients for spherical scatterers using Mie theory.
2. `mie_cross_section.m`: Compute the normalized scattering cross-section based on multipole coefficients. 

## Run examples
Examples of the surface/volume integration method are in `./examples`. You can follow the following steps to run the benchmark:
1. Run the COMSOL file `silicon_sphere.mph` and store each step of the parameter sweep in `./step`
2. Run the script `main_surface.m`/`main_volume.m`.
3. Run the script `main_mie.m`.
4. Run the script `numerical_and_mie_plot.m` to visualize the results.
