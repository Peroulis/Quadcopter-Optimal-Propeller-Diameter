# Quadcopter-Optimal-Propeller-Diameter

In the context of the graduate program 'Mechanical and Aeronautical Engineering' in Patras, Greece, a thesis has been held. This thesis is about the design and build a mUAV - Quadcopter:

link: https://www.researchgate.net/publication/315647771_Design_and_Manufacture_of_a_mUAV_-_Quadcopter
ResearchGate DOI: 10.13140/RG.2.2.13679.23203

Part of the design process was the research about the optimal propeller diameter of the quadcopter. The following code in Matlab calculates the optimal propeller diameter taking into consideration:

User inputs the additional weights (frame, motor, battery, extra load). 
Also, the user inputs the battery properties (cells, Ah)

The program outputs the results for each propeller diameter.

1. Propeller Diameter

2. PDT stands for Theory of Power Disk, the basic theory of Propeller Power requirement based on the Bernoulli equations. 

3. Profile Drag is the Power required to overcome the blades' profile Drag according to the UIUC propeller DataBase. 
http://m-selig.ae.illinois.edu/props/propDB.html

4. Total required power in Watts.

5. Drone Autonomy in minutes. 



*****Important NOTE_1: propeller_power.m file includes a "FM" variable.

FM stands for Figure of Merit and takes values from 0.7 to 1.0
(Conlisk, A. Modern Helicopter Aerodynamics. Columbus: The Oxio State University)

*****Important NOTE_2: propeller_power.m file includes a 0.6 value in line 65. 

This value stands for the the electronics performance. 
