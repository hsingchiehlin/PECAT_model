Integrate (Lsodes, 1e-12, 1e-11, 1);

# Absorption on(1)/off(0) switches
f_Abs_stom  = 0;
#f_Abs_duod  = 0;
#f_Abs_jeju  = 0;
#f_Abs_ileum = 0;
#f_Abs_cecum = 0;
#f_Abs_colon = 0;

s_jeju_ratio = 1;

# put peff ratio distributions
Peff_ratio_duod_jeju = 1;
Peff_ratio_ileum_jeju = 1;
Peff_ratio_colon_jeju = 1;
Peff_ratio_ivive = 1;

# Switches off intestine epithilia and kidney metabolite
Vmax_met_vitro_intestine = 0;

# using mean of post distribution 
Peff = 3.600000e-06;      
Fu_plasma = 0.2021;      
Fu_vitro_liver = 0.0711;      
Kpuu_liver =  4.5388;                        
Vmax_met_vitro_liver = 0.0009; 


# Weibull delayed release parameters
Weibull_slope_IR = 1; 
Weibull_slope_SR = 1; 
Weibull_slope_ER = 1.7802;
Weibull_scale_IR = 0.1741;
Weibull_scale_SR = 1.2392; 
Weibull_scale_ER = 2.1054;


Simulation{
  
  BDM = 73.4; 
  R_type = 0; 
  
  
  G_immediate_d = 1;
  Oral_dose_rate = 312.8389; #312.8389
  

  PrintStep (F_bio, 1, 10000, 100);

};

END.