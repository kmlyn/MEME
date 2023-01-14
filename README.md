## Maximum Entropy Model for Enzyme (MEME)

The code was initially developed by W.J Xie and B. Zhang at MIT studying the statistical physics of epigenome ([W.J. Xie and B. Zhang, Biophys Journal, 2019, 116, 2047-2056](https://www.sciencedirect.com/science/article/pii/S0006349519303066)). In the current version, the code was slightly modified to study protein evolution ([W.J. Xie, M. Asadi, and A. Warshel, PNAS, 2022, 119, e2122355119](https://www.pnas.org/content/119/7/e2122355119)).

### Descriptions
Programs to parameterize the MaxEnt model. Three techniques are used to accelerate the optimization: replica-exchange MCMC, MPI, and momentum-assisted SGD optimizer.

### Dependencies
The code was tested by the original author with the following versions of Fortran compiler and MPI:
GFortran v8.3.0, MPICH v3.3.2
Other versions may work as well.

### Input
statistics from MSA (experimental_constraints.txt; single-body frequencies are followed by pairwise frequencies.)

### Output
parameters of the MaxEnt model (IsingHamiltonian_field.txt, IsingHamiltonian_coupling.txt in the params subfolder), the MaxEnt energy for mutated sequences (msa_mut_MaxEnt_energy.txt)
 
### Modules
init.f90 (initialize parameters), global.f90 (global variables used in all modules), hamiltonian.f90 (calculate configuration energies), mc_sampling.f90 (MC simulation module), ensemble_average.f90 (module to calculate statistics from simulated MSA), main.f90 (main module for the parameterization), energy.f90 (MaxEnt energy calculation given the mutated sequences). Due to size limit, the intermediate results for a specific example are not provided.

### What changed compared to the original code
* Code organization
* Build system added
* Added some sanity checks and removed some hardcoded values perhaps specific for the research paper MEME was published with
* All binaries have meme_ prefix added to improve name uniqueness

### How to use
This branch of the original repo fork uses an industry standard tool CMake to build the project.
Create a project folder and subfolders params and output under it. Place experimental_constraints.txt and msa_mut_non_gap.txt files created with Python code provided by the original author in a Jupyter notebook as supplementary information for their PNAS paper referenced at the top of this document. You will also need input.txt file with parameters specific for your project (original one can be found in examples subdirectory).

Next, run:
* meme_init – this will process experimental_constraints.txt and create initial IsingHamiltonian_field.txt, IsingHamiltonian_coupling.txt in the params subfolder
* meme_main – this is MPI-enabled program, you will likely use it in an HPC environment using a proper run script for your queuing system; during the run, IsingHamiltonian_field.txt and IsingHamiltonian_coupling.txt in the params subfolder are updated, ensemble_average.txt in output folder is created (and updated); in a log.txt file you can find run configuration and can track current difference between current results and constraints; the program stops when this difference falls below 0.05;
* meme_energy – it uses the parameters to calculate results for the mutants present in msa_mut_non_gap.txt and writes msa_mut_MaxEnt_energy.txt;
