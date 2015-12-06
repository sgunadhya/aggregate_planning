set TIME;
set TIME_SHIFT;
set INIT;
set END;

var EMPLOYEES{i in TIME_SHIFT} integer >= 0;
var FIRED_EMPLOYEES{i in TIME} integer >= 0;
var HIRED_EMPLOYEES{i in TIME} integer >= 0;

var INVENTORY{i in TIME_SHIFT} integer >= 0;
var OVERTIME{i in TIME} integer >= 0;
var BACKORDER{i in TIME_SHIFT} integer >= 0;
var INTERNAL{i in TIME} integer >= 0;
var OUTSRC{i in TIME} integer >= 0;


param demand{i in TIME};

param cm;
param ci;
param cb;

param ct;
param cf;
param ch;
param cw;
param co;
param cc;

param L;
param H;
param M;

param init_employees;
param init_backorders;
param init_inventory;

param end_inventory_min;
param end_backlog_max;
param end_employees_min;
param end_employees_max;

minimize cost: sum{i in TIME} (cw*EMPLOYEES[i] + ch*HIRED_EMPLOYEES[i] + cf*FIRED_EMPLOYEES[i] + co*OVERTIME[i] + ci*INVENTORY[i] + cb*BACKORDER[i] + cm*INTERNAL[i] + cc*OUTSRC[i]);
s.t. cap_constraint{i in TIME}:L*INTERNAL[i] - H*EMPLOYEES[i] - OVERTIME[i] <= 0;
s.t. workforce{i in TIME}: EMPLOYEES[i] - EMPLOYEES[i - 1] - HIRED_EMPLOYEES[i] + FIRED_EMPLOYEES[i] = 0;
s.t. inventory{i in TIME}: INVENTORY[i] - INVENTORY[i - 1] - INTERNAL[i] - OUTSRC[i] + demand[i] + BACKORDER[i-1] - BACKORDER[i] = 0;
s.t. overtime{i in TIME}:OVERTIME[i] - M*EMPLOYEES[i] <= 0;
s.t. init_workforce_constraint{i in INIT}: EMPLOYEES[i] = init_employees;
s.t. init_inventory_constraint{i in INIT}: INVENTORY[i] = init_inventory;
s.t. init_backorder_constraint{i in INIT}: BACKORDER[i] = init_backorders;

s.t. end_workforce_constraint{i in END}: EMPLOYEES[i] <= end_employees_max;
s.t. end_workforce_constraint_min{i in END}: EMPLOYEES[i] >= end_employees_min;
s.t. end_inventory_constraint{i in END}: INVENTORY[i] >= end_inventory_min;
s.t. end_backorder_constraint{i in END}: BACKORDER[i] <=  end_backlog_max;

solve;