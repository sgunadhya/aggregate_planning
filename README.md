Aggregate Planning using Linear Programming
============================================
This is a project to implement Aggregate planning Linear Program in S&OP Supply Chain Management.
The project implements a Linear Programming model to solve the aggregate planning problem in S&OP process.
The model uses input parameters like cost of materials, cost of hiring an employee, cost of firing an employee,
cost of an employee, cost of back orders, cost of inventory, cost of outsourcing etc. The model outputs the minimum 
cost and other planning parameters like number of employees to hire, number of employees to fire, total orders 
processed in house, total orders outsourced, overtime etc.

To solve the problem, you will need the `glpsol` command from the `glpk` toolkit.
Run the command like so:

  `glpsol -m aggregate_planning.mod -d aggregate_planning.dat -o aggregate_planning_results.out`

You can use the sample `aggregate_planning.dat.sample` file to run the command.

