# Brain-wide neural recordings in mice navigating physical spaces enabled by a cranial exoskeleton

Description of custom code and associated data reported in the following manuscript.

**Last updated:** James Hope 2023-11-06

**Contact:** Raise issues via this repo or email to [Suhasa B. Kodandaramaiah](https://cse.umn.edu/me/suhasa-kodandaramaiah) -- suhasabk@umn.edu -- with any questions

---

## MANUSCRIPT INFORMATION

### Title

["Brain-wide neural recordings in mice navigating physical spaces enabled by a cranial exoskeleton"](https://www.biorxiv.org/content/10.1101/2023.06.04.543578v1)

### Authors

James Hope<sup>1</sup> , Travis Beckerle<sup>1</sup>, Pin-Hao Cheng<sup>1</sup>, Zoey Viavattine<sup>1</sup>, Michael Feldkamp<sup>1</sup>, Skylar Fausner<sup>1</sup>, Kapil Saxena<sup>1</sup>, Eunsong Ko<sup>1</sup>, Ihor Hryb<sup>1,3</sup>, Russell Carter<sup>2</sup>, Timothy Ebner<sup>2</sup>, Suhasa Kodandaramaiah<sup>1,2,3,^</sup>

### Affiliations

1. Department of Mechanical Engineering, University of Minnesota, Twin Cities
2. Department of Neuroscience, University of Minnesota, Twin Cities
3. Department of Biomedical Engineering, University of Minnesota, Twin Cities

<sup>^</sup>Corresponding author

Send manuscript correspondence to:

[Suhasa B. Kodandaramaiah](https://cse.umn.edu/me/suhasa-kodandaramaiah)  
Department of Mechanical Engineering  
University of Minnesota, Twin Cities  
Address: 111 Church St SE, Room 303, Minneapolis, MN 55455

---

## LICENSE

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

The above manuscript shall be cited appropriately.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

---

## SYSTEM REQUIREMENTS

[MATLAB 2021b (Mathworks)](https://www.mathworks.com/products/matlab.html) or later is required to run custom MATLAB code to analyze data. The open-source software [suite2p](https://github.com/MouseLand/suite2p) is required to view the results of calcium imaging processing in suite2p. The open-source software [phy GUI](https://github.com/cortex-lab/phy) is required to view the results of electrophysiology processing in phy GUI. Python is required to run [suite2p](https://github.com/MouseLand/suite2p) and [phy GUI](https://github.com/cortex-lab/phy) - see respective GitHub repositories for version information and system requirements.

---

## INSTALLATION GUIDE

MATLAB code will run on any PC with [MATLAB 2021b (Mathworks)](https://www.mathworks.com/products/matlab.html)  installed. See the [suite2p](https://github.com/MouseLand/suite2p) and [phy GUI](https://github.com/cortex-lab/phy) GitHub repositories (links above) for respective installation guides.

---

## DEMO

A demo is not provided for MATLAB code because the code is specific to the associated data, and most sections of code take < 1 minute to execute. See the INSTRUCTIONS below for how to run the code. A demo is not provided for [suite2p](https://github.com/MouseLand/suite2p) and [phy GUI](https://github.com/cortex-lab/phy) because these open-source software packages are described elsewhere. See respective GitHub repositories for information on how to run the code.

---

## INSTRUCTIONS FOR USE

Custom MATLAB software codes are provided with all the data necessary to run the code. Each section has a script prefixed with "`MAIN`" which is used to run the functions within that section. Below is a description of the folder structure, data locations, and an overview of functions within each `MAIN` script.
### 1. Exoskeleton Design Optimization

- **Exoskeleton - 1. Design**
	- `MAIN_Design_optimization.m`
		- Performs kinematics calculations to determine the exoskeleton geometries that encompass the desired behavioral arena. Then takes the compatible exoskeleton geometries and performs dynamics calculations to determine the required motor torque and velocities required to produce mouse velocities and accelerations. The optimal exoskeleton geometry produce low motor torque and velocity, subject to other considerations such as commerically available motor specifications.
		- `INPUT`: Behavioral arena size, desired angular range of motion of exoskeleton.
		- `OUTPUT`: Isoplots of peak motor torque and peak motor velocity for different exoskeleton geometries.
		- `RUN TIME`: ~ 10 minutes.
	- `MAIN_workspace_analysis.m`
		- Performs kinematics calculations to determine the exoskeleton geometries that encompass the desired behavioral arena. 
		- `INPUT`: Behavioral arena size, desired angular range of motion of exoskeleton.  
		-	`OUTPUT`: Surface plot of the exoskeleton geometry solution space.
		-	`RUN TIME`: ~ 2 minutes.	

- **Exoskeleton - 2. Kinematics**
	- `MAIN_Kinematics_and_Workspace.m`
		- Forward and inverse kinematics of the exoskeleton.
		- `INPUT`: Exoskeleton geometry.
		- `OUTPUT`: Stationary visualization of the exoskeleton. Workspace of the exoskeleton.
		- `RUN TIME`: < 1 minute.
	- `MAIN_Kinematics_Trajectory.m`
		- Visualize the exoskeleton executing a 6 DOF trajectory. 3 example trajectories provided.
		- `INPUT`: Exoskeleton geometry.
		- `OUTPUT`: Time-lapse plot of exoskeleton executing trajectory.
		- `RUN TIME`: < 1 minute.
	

- **Exoskeleton - 3. Jacobian and trajectory**
	- `MAIN_generate_trapezoidal_profile.m`
		- Analyzes the motor velocity and acceleration for a trapezoidal velocity trajectory in Cartesian space (i.e., the mouse's velocity).
		- `INPUT`: Exoskeleton geometry; trapezoidal velocity.
		- `OUTPUT`: Plot of trapezoidal velocity vs. time. Time-lapse plot of exoskeleton executing trajectory. Plot of motor (joint) velocity vs. time. Plot of motor acceleration vs. time.
		- `RUN TIME`: < 1 minute.
	
	- `MAIN_generate_freely_behaving_profile.m`
		- Analyzes the motor velocity and acceleration for actual data acquired on a mouse.
		- `INPUT`: Exoskeleton geometry; 3D mouse position tracking data (`Mesoscope_data.mat`).
		- `OUTPUT`: Plot of mouse velocity vs. time. Time-lapse plot of exoskeleton executing mouse motion. Plot of motor (joint) velocity vs. time. Plot of motor acceleration vs. time.
		- `RUN TIME`: < 1 minute.			

- **Exoskeleton - 4. Dynamics**
	- `MAIN_Dynamics.m`
		- Analyzes motor torque across a given trajectory.
		- `INPUT`: Exoskeleton geometry; motor joint position vs. time data (`Mesoscope_trajectory.mat`) generated from 3D mouse position tracking data (`Mesoscope_data.mat`).
		- `OUTPUT`: Plots of total motor torque vs. time, and of gravitational, inertial, velocity, and coupling motor torques vs. time.
		- `RUN TIME`: < 1 minute.
		
- **Exoskeleton - 5. Bandwidth**
  - `Admittance3DoF_1axis_oursystemwithZps2Hzoh.mlx`
    - Performs state-space (Laplace space) calculation of the exoskeleton and controller system bandwidth.
    - `INPUT`: Exoskeleton geometry; mouse position, velocity, and acceleration; controller parameters.
    - `OUTPUT`: Bode plots of bandwidth.
    - `RUN TIME`: < 1 minute.


### 2. Admittance Controller Tuning
	
- **Admittance - 1. Freely behaving**
	- DLC data
		- Raw data output from DeepLabCut animal tracking experiments of 3 mice within an open field arena (.csv, .h5, and .mp4 file formats). Several trials are concatenated into each dataset.
		- Raw data converted to MATLAB format (`.mat` format).
		- Animal experiments were performed on mice docked with mesoscope [(Rynes et al Nat. Meth. 2021)](https://www.nature.com/articles/s41592-021-01104-8).
	- `MAIN_Op_space_pos.m`
		- Loads raw DeepLabCut data and calculates the mouse's global position (op-space).
		- `INPUT`: raw DLC data.
		- `OUTPUT`: Plots of position vs. time.
		- `RUN TIME`: < 1 minute.
	- `MAIN_AV_profiles_fromDLC.m`
		- Loads raw DeepLabCut data and calculates the velocity and acceleration in the mouse's coordinate frame. Data sets (which contain several concatenated trials) are subdivided into different trials.
		- `INPUT`: raw DLC data.
		- `OUTPUT`: Plots of velocity vs. time; acceleration vs. time; velocity vs. acceleration.
		- `DATA OUTPUT`: AV_data = structured variable containing results. 
		> AV_data.fb_.v_ = velocity, \
		AV_data.fb_.a_ = acceleration, \
		AV_data.fb_.k_ = AV profile bounds, \
		AV_data.fb_ = mouse and trial.
		- `RUN TIME`: < 1 minute.
	- `MAIN_Plot_bounds.m`
		- Generates velocity-acceleration profiles from tracking data.
		- `INPUT`: AV_data generated from `MAIN_AV_profiles_fromDLC.m`.
		- `OUTPUT`: Plots of velocity vs. acceleration bounds in X, Y, and Yaw axes for each mouse and trial. Plots of velocity vs. acceleration bounds and raw data points in X, Y, and Yaw axes.
		- `RUN TIME`: < 1 minute.

- **Admittance - 2. X axis mousetrack**
	- Tuning Data and Figures
		- `MAIN_GenAVprofiles_TuningData.m`
			- Loads raw data from mouse maneuvering the exoskeleton around the linear mouse-track with different admittance controller virtual mass and damping properties and computes the force-velocity-acceleration profiles.
			- `INPUT`: raw data files (`M___.mat`).
			- `OUTPUT`: Plots of velocity, acceleration, and force data (NB: plots untitled).
			- `DATA OUTPUT`: `AV_data.mat` = structured variable containing results. 
			>AV_data.\*\*.vx = x velocity; \
			AV_data.\*\*.ax = x acceleration; \
			AV_data.\*\*.fx = x force; \
			AV_data.\*\*.kx = indices of the bounds of the va profile; \
			AV_data.\*\*.Qx = area of bounds of the va profile. \
			\*\* = high, low, tuned impedance (inverse of admittance).
			- `RUN TIME`: < 1 minute.
		
	- Tuned Mousetrack - Full Data
		- `MAIN_Analyze_TunedMousetrackData_v1.m`
			- Loads raw data from mouse maneuvering the exoskeleton around the linear mouse-track with tuned admittance controller virtual mass and damping properties and computes the force-velocity-acceleration profiles.
			- `INPUT`: raw data files (`M___.mat`).
			- `OUTPUT`: Plots of velocity, acceleration, and force data (NB: plots untitled).
			- `DATA OUTPUT`: `AV_data.mat` = structured variable containing results. 
			>AV_data.\*\*.vx = x velocity; \
			AV_data.\*\*.ax = x acceleration; \
			AV_data.\*\*.fx = x force; \
			AV_data.\*\*.kx = indices of the bounds of the va profile; \
			AV_data.\*\*.Qx = area of bounds of the va profile. \
			\*\* = high, low, tuned impedance (inverse of admittance).
			- `RUN TIME`: < 1 minute.

	- `MAIN_StatsAVF_AllData.m`
		- Loads `AV_data.mat` and performs statistical analyses on the data in the mouse's X-axis.
		- `INPUT`: `AV_data.mat` (generated using `MAIN_GenAVprofiles_TuningData.m` and `MAIN_Analyze_TunedMousetrackData_v1.m`).
		- `OUTPUT`: AV profile data bounds for mice maneuvering the exoskeleton and freely behaving; box plot and 1-way ANOVA analysis of velocity and acceleration peaks for each mouse; mean +/- standard deviation of velocity and accelerations for percentage range of values for mice maneuvering the exoskeleton and freely behaving; box plot and 1-way ANOVA analysis of velocity and acceleration peaks for freely behaving, tuned, and trained groups; box plots and 1-way ANOVA of forces for tuned and trained groups; velocity-acceleration profiles, velocity-time, and acceleration-time series for freely behaving and exoskeleton trained groups; force-velocity-acceleration raw data and admittance planes for high, tuned, and low impedance.


- **Admittance - 3. (X), Y and Yaw axis 8maze**
  - Tuning Data and Figures
    - `MAIN_GenAVprofiles_YandYAW.m`
      - Loads raw data from mouse maneuvering the exoskeleton around the 8-maze track with different admittance controller virtual mass and damping properties and computes the force-velocity-acceleration profiles.
      - `INPUT`: raw data files `M___.mat`.
      - `OUTPUT`: Plots of velocity and acceleration profiles.
      - `DATA OUTPUT`: `AV_data.mat` = structured variable containing results. 
	  >AV_data.\*\*.v_ = y or yaw velocity; \
	  AV_data.\*\*.a_ = y or yaw acceleration; \
	  AV_data.\*\*.f_ = y or yaw force; \
	  AV_data.\*\*.k_ = indices of the bounds of the va profile;  
	  AV_data.\*\*.Q_ = area of bounds of the va profile. \
	  \*\* = high, low, tuned impedance (inverse of admittance).
      - `RUN TIME`: < 1 minute.

  - `MAIN_StatsAVF_YData.m`
    - Loads `AV_data.mat` and performs statistical analyses on the data in the mouse's Y-axis.
    - `INPUT`: `AV_data.mat` (generated using `MAIN_GenAVprofiles_YandYAW.m`)
    - `OUTPUT`: Box plots of velocity and acceleration peaks for each mouse; box plots, bootstrap analysis, 1-way ANOVA test, and velocity-acceleration profile bounds for low, tuned, and high mass and damping values in the admittance controller.
    - `RUN TIME`: < 1 minute.

  - `MAIN_StatsAVF_YawData.m`
    - Loads `AV_data.mat` and performs statistical analyses on the data in the mouse's Yaw-axis.
    - `INPUT`: `AV_data.mat` (generated using `MAIN_GenAVprofiles_YandYAW.m`).
    - `OUTPUT`: Box plots of velocity and acceleration peaks for each mouse; box plots, bootstrap analysis, 1-way ANOVA test, and velocity-acceleration profile bounds for low, tuned, and high mass and damping values in the admittance controller.
    - `RUN TIME`: < 1 minute.


### 3. Gait analysis

- **Raw data**
	- Raw data output from DeepLabCut animal tracking experiments of mice locomoting around the oval-track while freely behaving and while maneuvering the exoskeleton (.csv, .h5, and .mp4 file formats).

- `MAIN_analyze_gait.m`
	- Loads raw data acquired from DeepLabCut tracking, extracts gait metrics, and performs statistical analysis.
	- `INPUT`: Raw data located in "Raw data" folder.
	- `OUPUT`: Scatter plot and box plot of step length and cadence for freely behaving mice and mice maneuvering the exoskeleton; 1-way ANOVA test comparing groups.
	- `RUN TIME`: < 1 minute.


### 4. 8Maze Task Behavior

- **8maze - 1. Exoskeleton training**
	- 8maze Exo Training - Full data
		- `MAIN_Analyze8mazedata.m`
			- Loads raw data acquired on mice maneuvering the exoskeleton around the 8-maze during turn training and analyzes performance.
			- `INPUT`: raw data (`Mouse__.mat`).
			- `OUTPUT`: "Eightmaze" = structured variable containing results; plots of turn paths.
			- `RUN TIME`: < 1 minute.

	- `MAIN_Stats_on_8mazeData.m`
		- Loads `Eightmaze.mat` and then performs statistical analysis.
		- `INPUT`: `Eightmaze.mat` (generated using `MAIN_Analyze8mazedata.m`).
		- `OUTPUT`: Plot of the number of trials per session; plot of the turn paths for all mice on day 1 and final day; line plot and mean +/- 95% confidence interval (CI-binomial) plots of performance for all mice.
		- `RUN TIME`: < 1 minute.


-	**8maze - 2. Freely behaving**
	- 8maze task training data
		- `MAIN_Generate_FB_8maze_data.m`
			- Compiles raw data manually scored on mice performing the 8-maze task decision-making while freely behaving and then analyzes performance.
			- `INPUT`: Raw data within script.
			- `OUTPUT`: `FB_8maze.mat` = structured variable containing results.
			- `RUN TIME`: < 1 minute.

	- `MAIN_Stats_on_8mazeFB.m`
		- Loads `FB_8maze.mat` and then performs statistical analysis on performance.
		- `INPUT`: `FB_8maze.mat` (generated using `MAIN_Generate_FB_8maze_data.m`).
		- `OUTPUT`: Line plot, mean +/- 95% confidence interval (CI-binomial) plot, and ANOVA plot of performance across sessions for all mice performing 8-maze task freely behaving.
		- `RUN TIME`: < 1 minute.


- **8maze - 3. Exoskeleton decision making**
  - 8maze Exo Decisions - Full data
    - `MAIN_Analyze8mazeDecisiondata.m`
      - Loads raw data acquired on mice maneuvering the exoskeleton around the 8-maze task during decision-making and analyzes performance.
      - `INPUT`: raw data `Mouse__.mat`.
      - `OUTPUT`: "Decisions" = structured variable containing results; plots of turn paths.
      - `RUN TIME`: < 1 minute.

  - `MAIN_Stats_on_8mazeDecisions.m`
    - Loads `Decisions.mat` and then performs statistical analysis on performance.
    - `INPUT`: `Decisions.mat` (generated using `MAIN_Analyze8mazeDecisiondata.m`).
    - `OUPUT`: Plots of the number of trials per session for each mouse and the total trials per session; plots of the correct and incorrect turn paths for all mice across sessions; plots of the performance of each mouse across sessions; 1-way ANOVA and mean +/- 95% confidence interval (CI-binomial) plot of all mice across sessions; box plots and 1-way ANOVA of tortuosity across sessions for correct and incorrect trials; box plots of Y and Yaw forces and force peaks across sessions for correct and incorrect trials; Kruskal-Wallis test comparing freely behaving and exoskeleton maneuvering decision-making performance across sessions 2 to 8.
    - `RUN TIME`: < 1 minute.

			
### 5. Mesoscale Image Data Processing

- Data for analysis
	- Raw exoskeleton data sets `Mouse___8maze___.mat` and suite2p data sets `Fall___.mat`		

- Raw Imaging data and suite2p processing results
	- Results from suite2p cell sorting (suite2p); Tiff series of raw data acquired on mesoscale imaging headstage (Tiff series); and movie of tiff series (`___ raw data.avi`) for 4 sessions across 4 mice: 
		> Mouse1 (982 230121); \
		Mouse2 (1050 230114); \
		Mouse3 (1229_230308); \
		Mouse4 (1267_230308); 

	
	- `MAIN_process_meoscope_data.m`
		- Analyzes imaging data, aligns exoskeleton data, and analyses spatial encoding using regression.
		- `INPUT`: files in the folder "`/Data for analysis`".
		- `OUTPUT`: Imaging window aligned with the Common Coordinate Framework (CCF) Atlas; box plot of cell diameter and aspect ratio; image of all cells color coded with the CCF regions; histogram of DF/F for all cells and by CCF region; box plot of DF/F by CFF region; plot of number of cells by CCF region; line plot of mouse position vs time showing start and end of imaging period; raw, normalized, and spatially organized Kernels from linear regression of mouse location to cell firing. For Mouse1 (982 230121): plots of spike rates for cells of interest overlaid on the 8-maze location; ROI boxes overlaid on imaging window; spike traces and cell locations in each ROI.
		- `RUN TIME`: < 10 minutes per session.
		

### 6. Electrophysiology Data Processing

- cvx
	- MATLAB linear algebra toolbox
		
- Ephys and Exo data
	- Results from exoskeleton (`Mouse___.mat`), Raw electrophysiology data from INTAN (`___.bin, ___.dat`), Kilosort 2.0 pre-processing of electrophysiology data, and phy GUI spike sorting for 10 sessions across 4mice:
		- Mouse1Day1 - 221010_1_ENN_M0837 - Phy 221103
		- Mouse1Day2 - 221003_1_ENN_M0837 - Phy 221103
		- Mouse1Day3 - 220930_2_ENN_M0837 - Phy 221103
		- Mouse2Day1 - 220811_1_ENN_M0845 - Phy 220909
		- Mouse2Day3 - 2220810_1_ENN_M0845 - Phy 220914
		- Mouse3Day1 - 220816_1_ENN_M0881 - Phy 230308
		- Mouse3Day2 - 220818_1_ENN_M0881 - Phy 230308
		- Mouse4Day1 - 230328_2_ENN_M1002 - Phy 230412
		- Mouse4Day2 - 230403_1_ENN_M1002 - Phy 230412
		- Mouse4Day3 - 230406_1_ENN_M1002 - Phy 230412

- `MAIN_exo_ephys_analysis_v9.m`
  - Post-processes ephys data, analyzes ephys data, and aligns exoskeleton data.
  - `INPUT`: files in the folder "`/Ephys and Exo data`".
  - `OUPUT`: plots of individual and mean spike waveforms for each cell on each probe; line plot of mouse position vs time showing start and end of ephys recording; plot of events (sound, turn, etc.) vs time; turn paths through decision zone colored for correct (green) or incorrect (red); TTL pulse alignment and drift between exoskeleton and ephys data sets; spike rasters overlaid with plots of events (sound, turn, etc.) vs time; scatter plot of spike amplitude of cells on each probe; box plots of noise vs velocity and force; scatter plot of spike amplitude vs number of spikes.
  - `DATA OUTPUT`: "`Mouse_Day__Srate_Bvars.mat`".
  - `RUN TIME`: 10 to 60 minutes per session.

- `MAIN_RedRankRegression.m`
  - Analyses spatial encoding using reduced rank regression between ephys data and exoskeleton data.
  - `INPUT`: "`Mouse_Day__Srate_Bvars.mat`" (generated using `MAIN_exo_ephys_analysis_v9.m`).
  - `OUPUT`: Plot of position bins around 8-maze; position kernel. 
  - For Mouse1Day1: plots of spike rates for cells of interest overlaid on the 8-maze location.



