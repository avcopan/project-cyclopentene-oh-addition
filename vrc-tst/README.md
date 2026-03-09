# Instructions

Input configuration files:
1. `structure.inp`: Add Cartesian structures for the two fragments, with isotopic numbers after the symbols
2. `inf.mol`: Molpro input to calculate the reference (infinite separation) energy. Often, you may need to read orbitals from a closer separation in order to converge at large separation. Run as follows:
```
module load molpro
molpro inf.mol
```
3. `sample.tml`: Template for energy sampling. Copy the reference (STATE 1.1) energy from `inf.out` and subtract it from the total energy, if it converged. If it didn't converge, set the energy to a high value, e.g. 10.0. The geometry gets substituted in at "GEOMETRY_HERE".
4. `divsur.inp`: Specify pivot points for each fragment. Zeros correspond to the center of mass.
5. `molpro.inp`: Configure molpro executable, geometry pattern, etc. The `dummy_corr_` sets which energies are used in which order. Put the index of the ground state energy first and, if using multiple levels of theory, put the best level of theory first, as this will be used to decide convergence.
6. `tst.inp`: Configure the vartiational TST determination. Things to set:
    - `tmpr_grid`: Temperature grid defined by $T_1$, $\Delta_1$, $S$, $N$ where $T_i = T_1 + \Delta_1 \frac{S^{i-1} - 1}{S - 1}$ for $i=1,\ldots,N$.
    - `ener_grid`: Energy grid, defined similarly. The scaling factor only kicks in when the energy is positive.
    - `flux_rel_err`: Defines flux convergence criterion, in terms of the number of standard deviations ($\sigma$) in the error bars.
    - `pes_size`: How many PESs are being evaluated, corresponding to the number of energies that are being calculated.

Run configuration files:
1. `machines`: Hostnames and number of slots to use.

Run as follows:
```
rotd -h csed-0019 -f machines tst.inp
```

Watch progress in `tst.log`


Finally:
1. `mc_flux.inp`: Input file for `mc_flux` executable. By default, it reads from `tst.inp`, so you only have to set the output file.
```
echo "OutputFile  mc_flux.dat" > mc_flux.inp
mc_flux mc_flux.inp
```
If you have multiple PESs, such as excited states, you can add the `"ElectronicSurface"` keyword to select one by index.
```
echo -e "OutputFile mc_flux0.dat\nElectronicSurface 0" > mc_flux0.inp
mc_flux mc_flux0.inp
echo -e "OutputFile mc_flux1.dat\nElectronicSurface 1" > mc_flux1.inp
mc_flux mc_flux1.inp
```
