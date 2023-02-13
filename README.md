# Automated Planning Assignment

This repository is a student project containing all files addressing the assignment of Automated Planning: Theory and Practice, course of the Master in Artificial Intelligent Systems at the University of Trento, a.y. 2022-2023.

For each sub-problem of the assignment, a corresponding folder has been created with domain and problem files and, if necessary, additional files to run them. In addition, a report has been added to explain what assumptions have been set and what trials have been done.

If interested, below the instructions to run the different sub-problems. 


## Requirements

Here the tools needed to perform the different parts of the assignment:
* sub-problem 1, 2 and 4: [planutils](https://github.com/AI-Planning/planutils)
* sub-problem 3: [PANDA](https://www.uni-ulm.de/en/in/ki/research/software/panda/panda-planning-system/)
* sub-problem 5: [plansys2](https://plansys2.github.io/) 

## Sub-problem 1

To run the first sub-problem:
1. Install planutils
2. Install planners through planutils. Planners used here are: FF, LAMA, LAMA-FIRST
4. Run ``run planutils planner domain_file problem_file``
For instance, run ``planutils lama domain.pddl problem.pddl``


## Sub-problem 2

To run the second sub-problem:
1. Install planutils
2. Install planners through planutils. Planners used here are: FF, LAMA, LAMA-FIRST
3. Run ``run planutils planner domain_file problem_file``



For instance, run ``planutils lama domain.pddl problem.pddl``


## Sub-problem 3
To run the third sub-problem:
1. Install PANDA
2. Run ``java -jar PANDA.jar –parser hddl domain_file problem_file``
Following this repository format, run ``java -jar PANDA.jar –parser hddl domain.hddl problem.hddl``

## Sub-problem 4

To run the fourth sub-problem:
1. Install planutils
2. Install planners through planutils. Planners used here are: TFD, OPTIC
3. Run ``run planutils planner domain_file problem_file``
For instance, run ``planutils TFD domain.pddl problem.pddl``


## Sub-problem 5

To run the fifth sub-problem:
1. Install plansys2
In one terminal: 
2. source /opt/ros/humble/setup.bash
3. colcon build --symlink-install
4. rosdep install --from-paths problem5 --ignore-src -r -y
5. colcon build --symlink-install
6. source install/setup.bash 
7. ros2 launch problem5 plansys2_launch.py
In another terminal:
8. source /opt/ros/humble/setup.bash
9. ros2 run plansys2_terminal plansys2_terminal
