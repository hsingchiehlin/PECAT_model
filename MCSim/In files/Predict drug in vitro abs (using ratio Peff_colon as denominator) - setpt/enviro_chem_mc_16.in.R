# ALL Switch on (SI + LI)
Integrate (Lsodes, 1e-12, 1e-12, 1);

SetPoints ("","setpts.out",0,
           Peff_ratio_duod_colon, Peff_ratio_jeju_colon, Peff_ratio_ileum_colon); 

# Absorption on(1)/off(0) switches
f_Abs_stom  = 0;
#f_Abs_duod  = 0;
#f_Abs_jeju  = 0;
#f_Abs_ileum = 0;
#f_Abs_cecum = 0;
#f_Abs_colon = 0;

s_jeju_ratio = 0;

# Switches off intestine epithilia and kidney metabolite
Vmax_met_vitro_intestine = 0;

# using mean of post distribution 
Peff = 0.0000468;      
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

  PrintStep (C_blood, 1,10000, 100);
  PrintStep (C_ss_equ, 1, 10000, 100);
  PrintStep (F_bio, 1, 10000, 100);


};

END.
