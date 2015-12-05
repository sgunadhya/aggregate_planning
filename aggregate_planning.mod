set TIME;

var EMPLOYEES{i in TIME};
var FIRED_EMPLOYEES{i in TIME};
var HIRED_EMPLOYEES{i in TIME};

var INVENTORY{i in TIME};
var OVERTIME{i in TIME};
var BACKORDER{i in TIME};
var INTERNAL{i in TIME};
var OUTSRC{i in TIME};


param demand{i in TIME};
param w;
param wT;
param i;
param iT;
param b;
param bT;
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

minimize cost: sum{i in TIME} (cw*EMPLOYEES[i] + ch*HIRED_EMPLOYEES[i] + cf*FIRED_EMPLOYEES[i] + co*OVERTIME[i] + ci*INVENTORY[i] + cb*BACKORDER[i] + cm*INTERNAL[i] + cc*OUTSRC[i]);
s.t. cap_constraint{i in TIME}:L*INTERNAL[i] - H*EMPLOYEES[i] - OVERTIME[i] <= 0;
s.t. workforce{i in TIME}: EMPLOYEES[i] - EMPLOYEES[i - 1] - HIRED_EMPLOYEES[i] + FIRED_EMPLOYEES[i] = 0;
s.t. inventory{i in TIME}: INVENTORY[i] - INVENTORY[i - 1] - INTERNAL[i] - OUTSRC[i] + demand[i] + BACKORDER[i-1] - BACKORDER[i] = 0;
s.t. overtime{i in TIME}:OVERTIME[i] - M*EMPLOYEES[i] <= 0;

solve;